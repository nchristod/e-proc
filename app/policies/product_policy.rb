class ProductPolicy < ProcurementPolicy

  def show?
    user
  end

  def index?
    user
  end

end
