require 'rails_helper'

describe UserPolicy do
  subject { UserPolicy.new(c_user, user) }

  let(:user) { FactoryGirl.create(:user) }

  context "for a visitor" do
    let(:c_user) { nil }

    it { should_not permit_auth(:index)    }

    it { should_not permit_auth(:update)  }
    
    it { should_not permit_auth(:destroy) }
  end

  context "for a simple user" do
    let(:c_user) { FactoryGirl.create(:user, :simple) }

    it { should_not permit_auth(:index)    }

    it { should_not permit_auth(:update)  }
    
    it { should_not permit_auth(:destroy) }
  end

  context "for an admin" do
    let(:c_user) { FactoryGirl.create(:user, :admin) }

    it { should permit_auth(:index)    }

    it { should permit_auth(:update)  }
    
    it { should permit_auth(:destroy) }
  end
end