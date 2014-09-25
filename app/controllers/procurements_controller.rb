class ProcurementsController < ApplicationController
  before_action :set_procurement, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:new]

  # GET /procurements
  # GET /procurements.json
  def index
    # @user = User.find(params[:user_id])
    @user = current_user
    @procurements = Procurement.all
    authorize @procurements
  end

  # GET /procurements/1
  # GET /procurements/1.json
  def show
    
    # @user = User.find(params[:user_id])
    @user = current_user
    authorize @procurement
  end

  # GET /procurements/new
  def new
    @user = current_user
    if @user.admin?
      @procurement = Procurement.new
    else
      redirect_to root_path
      flash[:alert] = "You must be an admin to do that."
    end
  end

  # GET /procurements/1/edit
  def edit
    authorize @procurement
    @user = User.find(params[:user_id])

    if !@user.admin?
      redirect_to root_path
      flash[:alert] = "You must be an admin to do that."
    end
  end

  # POST /procurements
  # POST /procurements.json
  def create
    @user = current_user
    
    #get the current_user and build the procurement
    # @procurement = @user.procurements.build(procurement_params)
    @procurement = Procurement.new(procurement_params)
    authorize @procurement

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
    authorize @procurement
    @user = User.find(params[:user_id])
    if @user.admin?
      respond_to do |format|
        if @procurement.update(procurement_params)
          format.html { redirect_to @procurement, notice: 'Procurement was successfully updated.' }
          format.json { render :show, status: :ok, location: @procurement }
        else
          format.html { render :edit }
          format.json { render json: @procurement.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
      flash[:alert] = "You must be an admin to do that."
    end
  end

  # DELETE /procurements/1
  # DELETE /procurements/1.json
  def destroy
    # @user = User.find(params[:user_id])
    @user = current_user
    
    if @user.admin?
      authorize @procurement
      @procurement.destroy
      respond_to do |format|
        format.html { redirect_to procurements_url, notice: 'Procurement was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path
      flash[:alert] = "You must be an admin to do that."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_procurement
      @procurement = Procurement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def procurement_params
      params.require(:procurement).permit(:id, :name, :proc_start_date, :proc_end_date, :proc_terms, :proc_delivery_date)
    end
end
