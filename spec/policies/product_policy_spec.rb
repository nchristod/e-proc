require 'rails_helper'

describe "Product Policy" do

  subject { ProductPolicy.new(user, product) }

  let(:product) { FactoryGirl.create(:product) }

  context "for an Admin" do
    let(:user) { FactoryGirl.create(:user, :admin) }

    it { should permit_auth(:index) }
    it { should permit_auth(:show) }
    it { should permit_auth(:edit) }
    it { should permit_auth(:update) }
  end

  context "for a Supplier" do
    let(:user) { FactoryGirl.create(:user, :supplier) }

    it { should permit_auth(:index) }
    it { should permit_auth(:show) }
    it { should_not permit_auth(:edit) }
    it { should_not permit_auth(:update) }
  end

end