class OfferPolicy < ApplicationPolicy

  class Scope < Struct.new(:user, :scope)
    def resolve
      if user && user.admin?
        scope.all 
      elsif user == nil
        scope.none
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def show?
    user.supplier? || user.admin?
  end

  def index?
    user.supplier? || user.admin?
  end

  def create?
    user.supplier? 
  end

  def edit?
    user.supplier? && belongs_to_user?
  end

  def update?
    user.supplier? && belongs_to_user? || user.admin?
  end

  def new?
    create? 
  end

  def destroy?
    user.supplier? && belongs_to_user?
  end

  def permitted_attributes
    if user.admin?
      [:tech_eval]
    elsif user.supplier?
      [:offer_technical, :offer_economical, :delivery_date, :product_id, :procurement_id, :user_id, documents: []]
    end
  end

end

