class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  before_filter :deny_creating_offers_for_others, only: [:new]

  def deny_creating_offers_for_others
    if current_user.id.to_s != params[:id]
      flash[:error] = "Access Denied..........."
      redirect_to procurements_path
    end
  end

  # GET /offers
  # GET /offers.json
  def index
    @user = current_user
    @offers = policy_scope(Offer)
    authorize @offers
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
    authorize @offer
  end

  # GET /offers/new
  def new
    @offer = Offer.new
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
        format.html { redirect_to [current_user, @offer], notice: 'Offer was successfully created.' }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    authorize @offer
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to [current_user, @offer], notice: 'Offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    authorize @offer
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to user_offers_url(current_user), notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:offer_technical, :offer_economical, :delivery_date, :product_id,  :procurement_id, :user_id)
    end
end
