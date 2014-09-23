require 'rails_helper'

RSpec.describe ProcurementsController do
  pending
#   let(:user) { FactoryGirl.create(:user) }
#   let(:supplier) { FactoryGirl.create(:user, :supplier) }
#   let(:admin) { FactoryGirl.create(:user, :admin) }
#   let(:procurement) { FactoryGirl.create(:procurement) }

#   context "Suppliers" do
#     # before  do
#     #   sign_in(:user, user)
#     # end

#     { :new => :get,
#       :create => :post,
#       :edit => :get,
#       :update => :put,
#       :destroy => :delete }.each do |action, method|
#         it "cannot access the #{action} action" do
#           sign_in(:supplier, supplier)
#           send(method, action, :id => procurement.id, user_id: supplier.id)
#           response.should redirect_to(root_path)
#           flash[:alert].should eql("You must be an admin to do that.")
#         end
#       end
#   end

#   context 'Admins' do
#     { :new => :get,
#       :create => :post,
#       :edit => :get,
#       :update => :put,
#       :destroy => :delete }.each do |action, method|
#         it "can access the #{action} action" do
#           sign_in(:admin, admin)
#           send(method, action, :procurement => procurement, :user_id => admin.id)
#           expect(response.status).to eq(200)
#         end
#       end
#   end
end
