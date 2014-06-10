class ProcurementsController < ApplicationController
  before_action :set_procurement, only: [:show, :edit, :update, :destroy]

  # GET /procurements
  # GET /procurements.json
  def index
    @procurements = Procurement.all
  end

  # GET /procurements/1
  # GET /procurements/1.json
  def show
  end

  # GET /procurements/new
  def new
    @procurement = Procurement.new
  end

  # GET /procurements/1/edit
  def edit
  end

  # POST /procurements
  # POST /procurements.json
  def create
    @procurement = Procurement.new(procurement_params)
    @procurement.user = current_user

    respond_to do |format|
      if @procurement.save
        format.html { redirect_to @procurement, notice: 'Procurement was successfully created.' }
        format.json { render :show, status: :created, location: @procurement }
      else
        format.html { render :new }
        format.json { render json: @procurement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /procurements/1
  # PATCH/PUT /procurements/1.json
  def update
    respond_to do |format|
      if @procurement.update(procurement_params)
        format.html { redirect_to @procurement, notice: 'Procurement was successfully updated.' }
        format.json { render :show, status: :ok, location: @procurement }
      else
        format.html { render :edit }
        format.json { render json: @procurement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /procurements/1
  # DELETE /procurements/1.json
  def destroy
    @procurement.destroy
    respond_to do |format|
      format.html { redirect_to procurements_url, notice: 'Procurement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_procurement
      @procurement = Procurement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def procurement_params
      params.require(:procurement).permit(:name, :proc_start_date, :proc_end_date, :proc_terms, :proc_delivery_date, :user_id)
    end
end
