feature 'Admin creates product',:devise do
  
  let(:admin) { FactoryGirl.create(:user, :admin) } 
  let(:category) { FactoryGirl.create(:category) } 
  let!(:product) { FactoryGirl.create(:product) }

  before(:each) do
    signin(admin.email, admin.password)
    visit new_product_path
  end 

  scenario 'with valid credentials' do
    select category.name, from: 'Category'
    fill_in "Name",  with: product.name
    fill_in "Description",  with: product.description 
    click_button "Create Product"
    expect(page).to have_content("Product was successfully created.")  
  end

  scenario 'with invalid credentials' do
    fill_in "Description",  with: "sometext"
    click_button "Create Product"
    expect(page).to have_content("Please review the problems below:") 
  end


end