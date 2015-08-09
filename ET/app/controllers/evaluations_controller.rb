class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: [:show, :edit, :update, :destroy]
  before_action :set_toilet

  # GET /evaluations
  # GET /evaluations.json
  def index
    @evaluations = Evaluation.all
  end

  # GET /evaluations/1
  # GET /evaluations/1.json
  def show
  end

  # GET /evaluations/new
  def new
    @evaluation = Evaluation.new
  end

  # GET /evaluations/1/edit
  def edit
  end

  # POST /evaluations
  # POST /evaluations.json
  def create
    @evaluation = @toilet.evaluations.build(evaluation_params)

    respond_to do |format|
      if @evaluation.save
	  c = @toilet.evaluations.count
	  p c
	  p @toilet.ave_rate
	  p (params[:evaluation][:clean].to_f + params[:evaluation][:comfort].to_f + params[:evaluation][:good_smell].to_f + params[:evaluation][:design].to_f + params[:evaluation][:find].to_f)/5
	   p ((c-1) * @toilet.ave_rate + (params[:evaluation][:clean].to_f + params[:evaluation][:comfort].to_f + params[:evaluation][:good_smell].to_f + params[:evaluation][:design].to_f + params[:evaluation][:find].to_f)/5) / c

	  	@toilet.update(:ave_rate => ((c-1) * @toilet.ave_rate + (params[:evaluation][:clean].to_f + params[:evaluation][:comfort].to_f + params[:evaluation][:good_smell].to_f + params[:evaluation][:design].to_f + params[:evaluation][:find].to_f)/5) / c)
        format.html { redirect_to @toilet, notice: 'Evaluation was successfully created.' }
        format.json { render :show, status: :created, location: @toilet }
      else
        format.html { render :new }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /evaluations/1
  # PATCH/PUT /evaluations/1.json
  def update
    respond_to do |format|
      if @evaluation.update(evaluation_params)
        format.html { redirect_to [@toilet, @evaluation], notice: 'Evaluation was successfully updated.' }
        format.json { render :show, status: :ok, location: [@toilet, @evaluation] }
      else
        format.html { render :edit }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  def destroy
    @evaluation.destroy
    respond_to do |format|
      format.html { redirect_to evaluations_url, notice: 'Evaluation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation
      @evaluation = Evaluation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_params
      params.require(:evaluation).permit(:clean, :comfort, :good_smell, :design, :find, :comment).merge(:user_id => current_user.id, :toilet_id => params[:toilet_id]).merge(:rate => (params[:evaluation][:clean].to_f + params[:evaluation][:comfort].to_f + params[:evaluation][:good_smell].to_f + params[:evaluation][:design].to_f + params[:evaluation][:find].to_f)/5)
    end

    def set_toilet
      @toilet = Toilet.find(params[:toilet_id])
    end
end
