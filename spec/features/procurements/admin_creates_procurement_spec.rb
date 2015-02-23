feature 'Admin creates procurement', :devise do

let(:user) { FactoryGirl.create(:user, :admin)  }
let!(:procurement) { FactoryGirl.build(:procurement) }

before(:each) do
  user.confirm!
  signin(user.email, user.password)
  visit new_procurement_path
end


  scenario 'with valid input', js: true do
    # skip "very slow js spec"
    select "Advantageous", from: "Κατηγορία"
    fill_in "Τίτλος",  with: procurement.name
    fill_in "Όροι/Σχόλια",  with: procurement.proc_terms
    fill_in "Ημ/νία Έναρξης", with: procurement.proc_start_date.strftime("%m/%d/%Y")
    fill_in "Ημ/νία Λήξης", with: procurement.proc_end_date.strftime("%m/%d/%Y")
    fill_in "Ημ/νία Παράδοσης", with: procurement.proc_delivery_date.strftime("%m/%d/%Y")
    click_button "Create Procurement"
    expect(page).to have_content('Procurement was successfully created.')
  end

  scenario 'with invalid input' do
    click_button "Create Procurement"
    expect(page).to have_content("Please review the problems below:")
  end

end