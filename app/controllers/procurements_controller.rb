class ProcurementsController < ApplicationController
  before_action :set_procurement, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:evaluation]

  # GET /procurements
  # GET /procurements.json
  def index
    # @user = User.find(params[:user_id])
    @user = current_user
    @procurements = Procurement.active.order(created_at: :desc).page(params[:page])
    authorize @procurements
    respond_to do |format|
      format.html
      format.atom {render layout: false}
    end
  end

  def archive
    @procurements = Procurement.expired.order(created_at: :desc).page(params[:page])
    authorize @procurements
    render 'procurements/index'
  end

  def evaluation
    @procurements = Procurement.expired.order(created_at: :desc).page(params[:page])
    @procurements.each do |procurement|
      authorize procurement
      procurement.offers.each do |offer|
        offer.unseal_technical! if offer.sealed?
        offer.unseal_economical! if offer.technical_evaluation?
      end
    end
    render 'procurements/evaluation'
  end

  def best_offers
    @procurements = Procurement.all.expired.order(created_at: :desc).page(params[:page])
    authorize @procurements
    render 'procurements/best_offers'
  end

  def set_best_offer
    procurement = Procurement.find(params[:procurement_id])
    authorize procurement
    p_prod = ProcurementProduct.find(params[:procurement_product_id])
    p_prod.update(best_offer_id: params[:offer_id])

    redirect_to best_offers_path
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
    @products = Product.all
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
          params[:documents].each do |document|
            @procurement.documents.create(document: document)
          end
        end
        format.html { redirect_to @procurement,
                      notice: 'Procurement was successfully created.' }
        format.json { render :show,
                      status: :created,
                      location: @procurement }
      else
        format.html { render :new }
        format.json { render json: @procurement.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /procurements/1
  # PATCH/PUT /procurements/1.json
  def update
    @user = current_user
    authorize @procurement
    if params[:documents]
      params[:documents].each { |document|
        @procurement.documents.create(document: document)
      }
    end
    if @user.admin?
      respond_to do |format|
        if @procurement.update(procurement_params)
          TenderNotifications.send_procurement_changed(@procurement)
          format.html { redirect_to @procurement,
                        notice: 'Procurement was successfully updated.' }
          format.json { render :show,
                        status: :ok,
                        location: @procurement }
        else
          format.html { render :edit }
          format.json { render json: @procurement.errors,
                        status: :unprocessable_entity }
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
        format.html { redirect_to procurements_url,
                      notice: 'Procurement was successfully destroyed.' }
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

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def procurement_params
    params.require(:procurement).permit(
      :id,
      :category,
      :name,
      :proc_start_date,
      :proc_end_date,
      :proc_terms,
      :proc_delivery_date,
      documents: [],
      procurement_products_attributes: [:product_id,
                                        :quantity,
                                        :requirements,
                                        :_destroy, :id])
  end

end
