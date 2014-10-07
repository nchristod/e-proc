class ProcurementPolicy < ApplicationPolicy

  def show?
    true
  end

  def index?
    true
  end

  def archive?
    user && user.admin?
  end

  def create?
    user && user.admin?
  end

  def edit?
    update?
  end

  def update?
    user && user.admin?
  end

  def new?
    create?
  end

  def destroy?
    user && user.admin?
  end

end
