class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: [:destroy]
  
  before_action :basic_auth, only: [:new]
  before_action :basic_auth_admin, except:[:new]
  # GET /evaluations
  # GET /evaluations.json
  def index
    @evaluations = Evaluation.all
  end

  # GET /evaluations/1
  # GET /evaluations/1.json
  def show
  end

  # GET /evaluations/(entryid)/new
  def new
    @entry = Entry.find(params[:id])
    @evaluation = Evaluation.new
  end

  # GET /evaluations/1/edit
  def edit
  end

  def update_evaluate entry

    if(entry.evaluations.size()!=0)
      mean = 0.0
      entry.evaluations.each do |i|
        mean += i.evaluate1
        mean += i.evaluate2
        mean += i.evaluate3
        mean += i.evaluate4.to_i
      end
      mean/=4*entry.evaluations.size()
      entry.update(evaluation:mean)
    else
      entry.update(evaluation:0)
    end
  end
  # POST /evaluations/(entryid)
  # POST /evaluations/(entryid).json
  def create
    @entry = Entry.find(params[:id])
    @evaluation = @entry.evaluations.find_by(school_num:params[:evaluation][:school_num])
    success_flag = true
    begin 
      if(@evaluation == nil)then
        
        @evaluation = Evaluation.create(evaluation_params)
        @entry.evaluations<<@evaluation
      else
        success_flag = @evaluation.update(evaluation_params)
      end
    rescue
      success_flag = false
    end
    if(success_flag)
      update_evaluate @entry
    end

    if @evaluation == nil
      @evaluation = Evaluation.new
    end
    respond_to do |format|
      if success_flag
        format.html { redirect_to @evaluation, notice: 'Evaluation was successfully created.' }
        format.json { render :show, status: :created, location: @evaluation }
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
        format.html { redirect_to @evaluation, notice: 'Evaluation was successfully updated.' }
        format.json { render :show, status: :ok, location: @evaluation }
      else
        format.html { render :edit }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  def destroy
    entry = @evaluation.entry
    @evaluation.destroy
    update_evaluate entry
    respond_to do |format|
      format.html { redirect_to evaluations_url, notice: 'Evaluation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation
      @evaluation = Evaluation.find(params[:id])
      @entry = @evaluation.entry
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_params
      params.require(:evaluation).permit(:school_num, :evaluate1, :evaluate2, :evaluate3, :evaluate4, :comment)
    end
end
