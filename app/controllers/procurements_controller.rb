class ProcurementsController < ApplicationController
  before_action :set_procurement, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /procurements
  # GET /procurements.json
  def index
    # @user = User.find(params[:user_id])
    @user = current_user
    @procurements = Procurement.all.active
    authorize @procurements
  end

  def archive
    @procurements = Procurement.all.expired
    authorize @procurements
    render 'procurements/archive'
  end

  # GET /procurements/1
  # GET /procurements/1.json
  def show
    @user = current_user
    authorize @procurement
    @procurement_products = @procurement.procurement_products
  end

  # GET /procurements/new
  def new
    @products = Product.all
    @user = current_user
    # if @user.admin?
    @procurement = Procurement.new
    @procurement.procurement_products.build
    authorize @procurement
    # else
    #   redirect_to root_path
    #   flash[:alert] = "You must be an admin to do that."
    # end
  end

  # GET /procurements/1/edit
  def edit
    @user = current_user
    authorize @procurement

    if !@user.admin?
      redirect_to root_path
      flash[:alert] = "You must be an admin to do that."
    end
  end

  # POST /procurements
  # POST /procurements.json
  def create
    #get the current_user and build the procurement
    @user = current_user
    @procurement = @user.procurements.build(procurement_params)
    authorize @procurement

    respond_to do |format|
      if @procurement.save
        if params[:documents]
          params[:documents].each { |document|
            @procurement.documents.create(document: document)
            }
        end        
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
    @user = current_user
    authorize @procurement
    # @user = User.find(params[:user_id])

    # if @user.admin?
      respond_to do |format|
        if @procurement.update(procurement_params)
          format.html { redirect_to @procurement, notice: 'Procurement was successfully updated.' }
          format.json { render :show, status: :ok, location: @procurement }
        else
          format.html { render :edit }
          format.json { render json: @procurement.errors, status: :unprocessable_entity }
        end
      end
    # else
    #   redirect_to root_path
    #   flash[:alert] = "You must be an admin to do that."
    # end
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
      params.require(:procurement).permit(:id, :category, :name, :proc_start_date, :proc_end_date, :proc_terms, :proc_delivery_date, procurement_products_attributes: [:id, :product_id, :quantity, :requirements, :_destroy], documents: [])
    end

end
