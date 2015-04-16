class ProcurementProduct < ActiveRecord::Base

  belongs_to :procurement, inverse_of: :procurement_products
  belongs_to :product
  has_many :offers, through: :product

  scope :done, -> { where.not(best_offer_id: nil) }

  def find_best_offer
    if self.best_offer_id.blank?
      if self.procurement.underbidding?
        # get unecrypted values
        unecrypted = []
        self.offers.each do |offer|
          val = {offer_id: offer.id, offer_economical: offer.offer_economical}
          unecrypted << val
        end
        # puts unecrypted
        # sort the array (first is lower economic offer)
        sorted = unecrypted.sort do |a,b|
          a[:offer_economical] <=> b[:offer_economical]
        end
        # puts sorted
        # check if there's more than one minimum offer
        min_offers = sorted.select do |o|
          o[:offer_economical] == sorted[0][:offer_economical]
        end
        # puts min_offers
        if min_offers.count == 1
          self.update(best_offer_id: min_offers[0][:offer_id])
        else
          # we need to return whole records
          conflicts = []
          min_offers.each {|entry| conflicts << Offer.find(entry[:offer_id])}
          return conflicts
        end
      else
        if self.offers.where(tech_eval: nil).count == 0
          sorted = self.offers.sort do |a,b|
            a.econ_tech_eval <=> b.econ_tech_eval
          end
          best_offers = sorted.select do |offer|
            offer.econ_tech_eval == sorted.last.econ_tech_eval
          end
          puts best_offers
          if best_offers.count == 1
            puts "One best offer"
            self.update(best_offer_id: best_offers[0].id)
            # return best_offers[0]
          else
            puts "Conflicts"
            return best_offers
          end
        else
          return "Review Technical Evaluations for this product."
        end
      end
    else
      false
    end
  end

end
