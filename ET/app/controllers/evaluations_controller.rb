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
			r = @evaluation.rate

			@toilet.update(:ave_rate => ((c-1) * @toilet.ave_rate + r)/c)

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
		old_r = @evaluation.rate
      	if @evaluation.update(evaluation_params)
			c = @toilet.evaluations.count
			new_r = @evaluation.rate

			@toilet.update(:ave_rate => (c * @toilet.ave_rate - old_r + new_r)/c)

			format.html { redirect_to @toilet, notice: 'Evaluation was successfully updated.' }
      	else
        	format.html { render :edit }
        	format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      	end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  def destroy
	r = @evaluation.rate
    if @evaluation.destroy
	c = @toilet.evaluations.count
		if (c == 0)
			@toilet.update(:ave_rate => 0)
		else
			@toilet.update(:ave_rate => (@toilet.ave_rate * (c+1) - r) / c)
		end
    respond_to do |format|
      format.html { redirect_to @toilet, notice: 'Evaluation was successfully destroyed.' }
      format.json { head :no_content }
    end
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
