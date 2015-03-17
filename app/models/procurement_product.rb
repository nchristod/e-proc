class ProcurementProduct < ActiveRecord::Base

  belongs_to :procurement, inverse_of: :procurement_products
  belongs_to :product
  has_many :offers, through: :product

  scope :done, -> { where.not(best_offer_id: nil) }

  def find_best_offer
    if self.best_offer_id.blank?
      if self.procurement.underbidding?
        min_offers = self.offers.select do |offer|
          offer.encrypted_offer_economical == self.offers.minimum(:encrypted_offer_economical)
        end
        if min_offers.count == 1
          self.update(best_offer_id: min_offers[0].id)
          # return min_offers[0]
        else
          return min_offers
        end
      else
        if self.offers.where(tech_eval: nil).count == 0
          sorted = self.offers.sort do |a,b|
            a.econ_tech_eval <=> b.econ_tech_eval
          end
          best_offers = sorted.select do |offer|
            offer.econ_tech_eval == sorted.last.econ_tech_eval
          end
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
