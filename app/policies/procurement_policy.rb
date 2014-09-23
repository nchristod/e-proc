class ProcurementPolicy < ApplicationPolicy

  def show?
    true
  end

  def index?
    @user
  end

  def create?
    @user && @user.admin?
  end

  def edit?
    @user && @user.admin?
  end

  def update?
    @user && @user.admin?
  end

  def new?
    @user && @user.admin?
  end

  def destroy?
    @user && @user.admin?
  end

end
