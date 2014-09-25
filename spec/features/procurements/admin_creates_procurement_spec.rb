feature 'Admin creates procurement', :devise do
  
let(:user) { FactoryGirl.create(:user, :admin)  }
let!(:procurement) { FactoryGirl.create(:procurement) }

before(:each) do
  signin(user.email, user.password)
  visit new_procurement_path
end


  scenario 'with valid input' do  
    fill_in "Title",  with: procurement.name
    fill_in "Terms and Conditions",  with: procurement.proc_terms
    click_button "Create Procurement"
    expect(page).to have_content('Procurement was successfully created.')  
  end

  scenario 'with invalid input' do
    click_button "Create Procurement"
    expect(page).to have_content("Please review the problems below:")
  end

end