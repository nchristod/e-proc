require 'rails_helper'

describe "Procurement Policy" do

  subject { ProcurementPolicy.new(user, procurement) }

  let(:procurement) { FactoryGirl.create(:procurement) }

  context "for a visitor" do
    let(:user) { nil }

    it { should     permit_auth(:show)    }
    it { should permit_auth(:index) }
    it { should_not permit_auth(:create)  }
    it { should_not permit_auth(:new)     }
    it { should_not permit_auth(:update)  }
    it { should_not permit_auth(:edit)    }
    it { should_not permit_auth(:destroy) }
  end

  context "for a user" do
    let(:user) { FactoryGirl.create(:user) }

    it { should permit_auth(:show)    }
    it { should permit_auth(:index) }
    it { should_not permit_auth(:create)  }
    it { should_not permit_auth(:new)     }
    it { should_not permit_auth(:update)  }
    it { should_not permit_auth(:edit)    }
    it { should_not permit_auth(:destroy) }
  end

    context "for an Admin" do
    let(:user) { FactoryGirl.create(:user, :admin) }

    it { should permit_auth(:show)    }
    it { should permit_auth(:index) }
    it { should permit_auth(:create)  }
    it { should permit_auth(:new)     }
    it { should permit_auth(:update)  }
    it { should permit_auth(:edit)    }
    it { should permit_auth(:destroy) }
  end
end