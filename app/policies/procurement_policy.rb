class ProcurementPolicy < ApplicationPolicy

  def show?
    true
  end

  def index?
    true
  end

  def archive?
    create?
  end

  def create?
    user && user.admin?
  end

  def edit?
    update?
  end

  def update?
    (user && user.admin?) && !expired?
  end

  def new?
    create?
  end

  def destroy?
    create?
  end

  def expired?
    record.proc_end_date < Date.today
  end

end
