feature 'Admin deletes procurement', :devise do 

  let(:admin) { FactoryGirl.create(:user, :admin) } 
  let(:procurement) { FactoryGirl.create(:procurement) } 

  scenario 'can delete procurement' do
    signin(admin.email, admin.password)
    visit procurement_path(procurement.id)
    click_link 'Delete'
    expect(page).to have_content('Procurement was successfully destroyed.')
  end
  
end