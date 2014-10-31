require 'rails_helper'

describe "Offer Policy" do

  subject { OfferPolicy.new(user, offer) }

  let(:offer) { FactoryGirl.create(:offer) }

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

    it { should permit_auth(:index) }
    it { should permit_auth(:new) }
    it { should permit_auth(:create) }

    context "when procurement is expired" do
      before :each do
        allow(offer).to receive_messages(expired?: true)
      end

      it { should_not permit_auth(:destroy) }
      it { should_not permit_auth(:edit) }
      it { should_not permit_auth(:update) }
    end

    context "when offer does not belong to user" do
      before :each do
        allow(subject).to receive_messages(belongs_to_user?: false)
      end

      it { should_not permit_auth(:show) }
      it { should_not permit_auth(:edit) }
      it { should_not permit_auth(:update) }
      it { should_not permit_auth(:destroy) }
    end
    
  end

end