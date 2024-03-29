class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  before_filter :deny_creating_offers_for_others, only: [:new]
  before_action :check_if_exists, only: [:create]

  def best_offers
    @procurements = Procurement.all.expired
  end

  def send_winner_email
    @offer = Offer.find(params[:id])
    authorize @offer
    TenderNotifications.tender_won(@offer).deliver
    flash[:notice] = "Email has been sent."
    redirect_to user_offer_path(@offer.user, @offer)
  end

  # GET /offers
  # GET /offers.json
  def index
    @user = current_user
    @offers = policy_scope(Offer).with_sealed_state
    authorize @offers
  end

  def index_old
    @user = current_user
    @offers = policy_scope(Offer).with_unsealed_state
    authorize @offers
    render "offers/index"
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
    @procurement_product = @procurement.procurement_products.
                                        find_by_product_id(@offer.product.id)
    authorize @offer
  end

  # GET /offers/new
  def new
    @offer = Offer.new
    @procurement = Procurement.find(params[:procurement_id])
    @product = Product.find(params[:product_id])
    authorize @offer
  end

  # GET /offers/1/edit
  def edit
    authorize @offer
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)
    authorize @offer
    respond_to do |format|
      if @offer.save
        if params[:documents]
          params[:documents].each { |document|
            @offer.documents.create(document: document)
            }
        end
        TenderNotifications.succesfull_submission(@offer).deliver
        format.html { redirect_to [current_user, @offer],
                      notice: 'Offer was successfully created.' }
        format.json { render :show,
                      status: :created,
                      location: @offer }
      else
        #probably needs redoing in params passing through actions
        format.html { render :new }
        format.json { render json: @offer.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    authorize @offer
    respond_to do |format|
      if @offer.update(offer_params)
        if params[:documents]
          params[:documents].each { |document|
            @offer.documents.create(document: document)
            }
        end
        format.html { redirect_to [current_user, @offer],
                      notice: 'Offer was successfully updated.' }
        format.json { render :show,
                      status: :ok,
                      location: @offer }
        # format.js
      else
        format.html { render :edit }
        format.json { render json: @offer.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  def update_tech_eval
    @offer = Offer.find(params[:offer_id])
    authorize @offer
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to evaluation_url,
                      notice: 'Technical evaluation was entered successfully.' }
        format.json { render :show,
                      status: :ok,
                      location: @offer }
        # format.js
      else
        format.html { render :edit }
        format.json { render json: @offer.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    authorize @offer
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to user_offers_url(current_user),
                    notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # This might need to be a policy
    def deny_creating_offers_for_others
      if current_user.id.to_s != params[:id]
        flash[:error] = "Access Denied."
        redirect_to procurements_path
      end
    end

    # Check if supplier made the same offer already and if so redirect him
    def check_if_exists
      if Offer.exists?(user_id: params[:user_id],
                      product_id: params[:offer][:product_id],
                      procurement_id: params[:offer][:procurement_id])

        redirect_to user_offers_path(current_user)
        flash[:error] = "Offer already created. Update it if you wish."
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
      @procurement = @offer.procurement
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).
             permit(*policy(@offer || Offer).permitted_attributes)
    end
end