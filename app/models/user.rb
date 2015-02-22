class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :supplier, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :procurements
  has_many :offers

  validates_presence_of :email
  validates_presence_of :password, if: :new_record?
  validates :terms, acceptance: true

  def set_default_role
    self.role ||= :supplier
  end

end
