class ProductPolicy < ProcurementPolicy

  def show?
    user
  end

  def index?
    user
  end

  def edit?
    user && user.admin?
  end

  def update?
    edit?
  end

end