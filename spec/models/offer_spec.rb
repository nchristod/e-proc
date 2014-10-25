require 'rails_helper'

RSpec.describe Offer, :type => :model do
  before :each do
    @offer = FactoryGirl.create(:offer)
  end

  it { should belong_to :procurement }
  it { should belong_to :user }
  it { should belong_to :product }
  it { should have_many :documents }
end
