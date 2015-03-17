class ProcurementPolicy < ApplicationPolicy

  def show?
    true
  end

  def index?
    true
  end

  def archive?
    true
  end

  def evaluation?
    set_best_offer?
  end

  def best_offers?
    create?
  end

  def set_best_offer?
    (user && user.admin?) && procurement_expired?
  end

  def create?
    user && user.admin?
  end

  def edit?
    update?
  end

  def update?
    (user && user.admin?) && !procurement_expired?
  end

  def new?
    create?
  end

  def destroy?
    create?
  end

  def procurement_expired?
    record.proc_end_date < Date.today
  end

end
