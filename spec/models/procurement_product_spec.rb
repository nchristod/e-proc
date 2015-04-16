require 'rails_helper'

RSpec.describe ProcurementProduct, :type => :model do

  subject { FactoryGirl.create(:procurement_product) }

  describe "#find_best_offer" do
    context "when procurement is underbidding" do
      let(:procurement) { FactoryGirl.create(:procurement, :underbidding) }

      xit "updates the best_offer_id" do
        # Factories are fucked up. Needs fixing
        allow(subject).to receive(:procurement).and_return(procurement)
        5.times { FactoryGirl.create(:offer, offer_economical: 10, procurement: procurement) }
        subject.find_best_offer
        expect(subject.best_offer_id).not_to be_nil
      end
    end

    context "when procurement is advantageous" do
      let(:procurement) { FactoryGirl.create(:procurement, :meat) }
    end
  end
end