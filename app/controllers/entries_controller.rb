class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  
  before_action :basic_auth,except:[:destroy]
  before_action :basic_auth_admin,only:[:destroy]
  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)
    success_flag=true
    params[:entry][:users].each do |user|
      begin
        user = User.new(grade: user[1][:grade].to_i, name: user[1][:name])
        if(user.grade<0||user.grade>5)then
          success_flag = false
          break
        end
        @entry.users<<user
      rescue
        success_flag = false
        break
      end
    end
    #params[:entry][:files].each do |file|
      #begin
    #    @entry.files<<file
      #rescue
      #  success_flag = false
      #  break
      #end
    #end
    
    #if(@entry.users.size()==0||(@entry.type!=0&&@entry.type!=1)) then
    #  success_flag = false
    #end
    if(success_flag) then
      begin
        #@entry.type = params[:type].to_i
        success_flag = @entry.save
      rescue
        
        success_flag = false
      end
    end
    respond_to do |format|
      if success_flag
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
    
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    
    success_flag=true
    @entry.users.clear
    params[:entry][:users].each do |user|
      begin
        user = User.new(grade: user[1][:grade].to_i, name: user[1][:name])
        if(user.grade<0||user.grade>5)then
          success_flag = false
          break
        end
        @entry.users<<user
      rescue
        success_flag = false
        break
      end
    end
    #if(@entry.users.size()==0||(@entry.type!=0&&@entry.type!=1)) then
    #  success_flag = false
    #end
    if(success_flag) then
      begin
      success_flag = @entry.update(entry_params)
      #success_flag = @entry.update(params[:type].to_i)
      rescue
        
        success_flag = false
      end
    end
    respond_to do |format|
      if success_flag
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:prodname,:type,:order,:evaorder,:teamname,:description,:users,files: [])
    end
end
