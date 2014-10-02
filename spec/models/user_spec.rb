describe User do

  before(:each) { @user = User.new(email: 'user@example.com') }

  subject { @user }

  it { should have_many :procurements }
  it { should have_many :offers }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  it 'sets default role to supplier' do
    expect(@user.role).to eq 'supplier'
  end

end
