require 'rails_helper'

RSpec.describe Category, :type => :model do
  before :each do
    @category = FactoryGirl.create(:category)
  end

  it { should validate_presence_of :name }

  it { should have_many(:products) }
end
