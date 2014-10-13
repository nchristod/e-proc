feature 'Admin creates procurement', :devise do
  
let(:user) { FactoryGirl.create(:user, :admin)  }
let!(:procurement) { FactoryGirl.build(:procurement) }

before(:each) do
  user.confirm!
  signin(user.email, user.password)
  visit new_procurement_path
end


  scenario 'with valid input' do  
    pending "need to manually select the dates.boring.."
    fill_in "Title",  with: procurement.name
    fill_in "Terms and Conditions",  with: procurement.proc_terms
    fill_in "Start Date", with: procurement.proc_start_date
    fill_in "End Date", with: procurement.proc_end_date
    fill_in "Delivery Date", with: procurement.proc_delivery_date
    click_button "Create Procurement"
    expect(page).to have_content('Procurement was successfully created.')  
  end

  scenario 'with invalid input' do
    click_button "Create Procurement"
    expect(page).to have_content("Please review the problems below:")
  end

end