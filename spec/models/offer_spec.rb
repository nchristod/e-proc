require 'rails_helper'

RSpec.describe Offer, :type => :model do
  before :each do
    @offer = FactoryGirl.build(:offer)
  end

  it { should belong_to :procurement }
  it { should belong_to :user }
  it { should belong_to :product }
  it { should have_many :documents }

  describe "#is_active?" do
    it "checks if the offer is active" do
      proc = @offer.procurement
      allow(proc).to receive(:proc_end_date).and_return(Date.today + 1)
      expect(@offer.is_active?).to be true
    end
  end
end
