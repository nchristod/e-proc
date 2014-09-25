require 'rails_helper'

RSpec.describe Product, :type => :model do
  
  it { should have_many :procurement_products }
  it { should belong_to :category }
end
