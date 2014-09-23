class UserPolicy < ApplicationPolicy
  # attr_reader :user, :record

  # def initialize(user, record)
  #   @user = user
  #   @record = record
  # end

  def index?
    @user && @user.admin?
  end

  def update?
    @user && @user.admin?
  end

  def destroy?
    @user && @user.admin?
  end

end
