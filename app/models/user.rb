class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :supplier, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :procurements
  has_many :offers

  # Setup accessible attributes for the model
  attr_accessible :user_id :name, :email, :sign_in_count, :created_at, :updated_at, :role, :last_sign_in_at, :current_sign_in_at

  def set_default_role
    self.role ||= :user
  end

end
