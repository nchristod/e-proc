class VisitorsController < ApplicationController

  def index
    @procurements = Procurement.all
  end

  def show
    @procurement = Procurement.find(params[:id])
  end

end
