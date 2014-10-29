require 'rails_helper'

describe "Offer Policy" do

  subject { OfferPolicy.new(user, offer) }

  let(:offer) { FactoryGirl.build(:offer) }

  context "for an Admin" do
    let(:user) { FactoryGirl.create(:user, :admin) }

    it { should_not permit_auth(:new) }
    it { should_not permit_auth(:create) }
    it { should permit_auth(:show) }
    it { should permit_auth(:index) }
    it { should_not permit_auth(:edit) }
    it { should permit_auth(:update) }
    it { should_not permit_auth(:destroy) }
  end

  context "for a Supplier" do
    let(:user) { FactoryGirl.create(:user, :supplier) }

    it { should permit_auth(:show) }
    it { should permit_auth(:index) }
    it { should permit_auth(:new) }
    it { should permit_auth(:create) }
    xit { should permit_auth(:destroy) }
    xit { should permit_auth(:edit) }
    xit { should permit_auth(:update) }
  end


end