class ToiletsController < ApplicationController
  before_action :set_toilet, only: [:show, :edit, :update, :destroy]

  # GET /toilets
  # GET /toilets.json
  def index
    if params[:men]
      @toilets = Toilet.mens(params[:lat].to_f, params[:long].to_f)
    elsif params[:women]
      @toilets = Toilet.womens(params[:lat].to_f, params[:long].to_f)
    else
      @toilets = []
    end
  end

  # GET /toilets/1
  # GET /toilets/1.json
  def show
  end

  # GET /toilets/new
  def new
  authenticate_user!
    @toilet = Toilet.new
  end

  # GET /toilets/1/edit
  def edit
 authenticate_user!
 end

  # POST /toilets
  # POST /toilets.json
  def create
 authenticate_user!
 @toilet = Toilet.new(toilet_params.merge(:ave_rate => 0))

    respond_to do |format|
      if @toilet.save
        format.html { redirect_to @toilet, notice: 'Toilet was successfully created.' }
        format.json { render :show, status: :created, location: @toilet }
      else
        format.html { render :new }
        format.json { render json: @toilet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /toilets/1
  # PATCH/PUT /toilets/1.json
  def update
  authenticate_user!
 respond_to do |format|
      if @toilet.update(toilet_params)
        format.html { redirect_to @toilet, notice: 'Toilet was successfully updated.' }
        format.json { render :show, status: :ok, location: @toilet }
      else
        format.html { render :edit }
        format.json { render json: @toilet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /toilets/1
  # DELETE /toilets/1.json
  def destroy
  authenticate_user!
    @toilet.destroy
    respond_to do |format|
      format.html { redirect_to toilets_url, notice: 'Toilet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_toilet
      @toilet = Toilet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def toilet_params
      params.require(:toilet).permit(:name, :lat, :long, :address, :western, :japanese, :multi, :urinals, :comment).merge(:user_id => current_user.id)
    end
end
