require 'rails_helper'

RSpec.describe Procurement, :type => :model do
  before :each do
    @proc = FactoryGirl.create(:procurement)
  end

  it { should have_many :products }
  it { should have_many :offers }
  it { should belong_to :user }

  it { should validate_presence_of :name }
  it { should validate_presence_of :proc_start_date }
  it { should validate_presence_of :proc_end_date }
  it { should validate_presence_of :proc_delivery_date }
  it { should validate_presence_of :proc_terms }
    
end
