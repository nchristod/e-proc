# encoding: utf-8

feature 'Admin edits procurement', :devise do

  let(:user) { FactoryGirl.create(:user, :admin) }
  let(:procurement) { FactoryGirl.create(:procurement) }

  before(:each) do
    FactoryGirl.create(:product)
    user.confirm!
    signin(user.email, user.password)
    visit edit_procurement_path(procurement)
  end

  scenario 'adds a product', js: true do
    click_link "Add"
    find("input[id*=quantity]").set "1"
    find('textarea[id*=requirements]').set 'Lorem ipsum'
    # find('select[name*=product_id]').find('option', text: 'MyString').click
    within_table('table1') do
      select 'MyString'
    end
    click_button 'Update Procurement'
    expect(page).to have_content('MyString')
  end

  scenario "adds an attachment" do
    attach_file('Συμπληρωματικά Έγγραφα', 'README')
    click_button 'Update Procurement'
    expect(page).to have_content('README')
  end

end