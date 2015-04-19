require 'rails_helper'

describe "Procurement Policy" do

  subject { ProcurementPolicy.new(user, procurement) }

  context "for an Admin" do
    let(:user) { FactoryGirl.create(:user, :admin) }
    let(:procurement) { FactoryGirl.create(:procurement) }

    it { should permit_auth(:show)    }
    it { should permit_auth(:index) }
    it { should permit_auth(:archive) }
    it { should permit_auth(:create)  }
    it { should permit_auth(:new)     }
    it { should permit_auth(:best_offers) }

    context "procurement expired" do
      let(:procurement) { FactoryGirl.create(:expired_procurement) }

      it { should_not permit_auth(:update) }
      it { should_not permit_auth(:edit) }
      it { should permit_auth(:destroy) }
      it { should permit_auth(:evaluation) }
    end

    context "procurement active" do
      let(:procurement) { FactoryGirl.create(:procurement) }

      it { should permit_auth(:update) }
      it { should permit_auth(:edit) }
      it { should permit_auth(:destroy) }
      it { should_not permit_auth(:evaluation) }
    end
  end

  context "for a Supplier" do
    let(:user) { FactoryGirl.create(:user, :supplier) }
    let(:procurement) { FactoryGirl.create(:procurement) }

    it { should permit_auth(:show)    }
    it { should permit_auth(:index) }
    it { should_not permit_auth(:evaluation) }
    it { should_not permit_auth(:create)  }
    it { should_not permit_auth(:new)     }
    it { should_not permit_auth(:update) }
    it { should_not permit_auth(:edit) }
    it { should_not permit_auth(:destroy) }
    it { should_not permit_auth(:best_offers) }
  end

  context "for a Visitor" do
    let(:user) { FactoryGirl.create(:user, :simple) }
    let(:procurement) { FactoryGirl.create(:procurement) }

    it { should permit_auth(:show)    }
    it { should permit_auth(:index) }
    it { should_not permit_auth(:evaluation) }
    it { should_not permit_auth(:create)  }
    it { should_not permit_auth(:new)     }
    it { should_not permit_auth(:update) }
    it { should_not permit_auth(:edit) }
    it { should_not permit_auth(:destroy) }
    it { should_not permit_auth(:best_offers) }
  end

end
