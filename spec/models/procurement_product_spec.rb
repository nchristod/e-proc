require 'rails_helper'

RSpec.describe ProcurementProduct, :type => :model do

  subject { FactoryGirl.create(:procurement_product) }

  describe "#find_best_offer" do
    context "when procurement is underbidding" do
      before :each do
        subject.procurement.update_attributes(category: 0)
      end

      it "stores the min offer" do
        expensive = FactoryGirl.create(:offer, procurement_id: 1, product_id: 1, offer_economical: 100)
        cheap = FactoryGirl.create(:offer, procurement_id: 1, product_id: 1, offer_economical: 1)
        subject.find_best_offer
        expect(subject.best_offer_id).to eq(cheap.id)
      end

      it "returns all minimum offers when conflicts" do
        5.times { FactoryGirl.create(:offer, offer_economical: 10, procurement_id: 1, product_id: 1) }
        confl = subject.find_best_offer
        expect(confl.count).to eq(5)
      end

      it "returns list of offers when conflicts" do
        5.times { FactoryGirl.create(:offer, offer_economical: 10, procurement_id: 1, product_id: 1) }
        confl = subject.find_best_offer
        expect(confl[0]).to be_a(Offer)
      end
    end

    context "when procurement is advantageous" do
      before :each do
        subject.procurement.update_attributes(category: 1)
      end

      it "stores the best offer" do
        off1 = FactoryGirl.create(:offer, procurement_id: 1, product_id: 1, tech_eval: 120)
        off2 = FactoryGirl.create(:offer, procurement_id: 1, product_id: 1, tech_eval: 1)
        subject.find_best_offer
        expect(subject.best_offer_id).to eq(off1.id)
      end

      it "returns all equal offers when conflicts" do
        3.times { FactoryGirl.create(:offer, offer_economical: 10, procurement_id: 1, product_id: 1, tech_eval: 80, delivery_date: Date.today) }
        conf = subject.find_best_offer
        expect(conf.count).to be(3)
      end

    end
  end
end