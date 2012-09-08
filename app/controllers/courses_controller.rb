class CoursesController < ApplicationController
  # GET /
  # The default dashboard
  def index
    if current_user.teacher?
      @course  = Course.new
      render "t_dashboard"
    else
      
    end
    
  end
  
  def show
    @course = Course.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sclass }
    end
  end
  
  def edit
    @course = Course.find(params[:id])
    
    respond_to do |format|
      format.html # edit.html.erb
    end
  end
  
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        @course.add_user(current_user,0)
        format.html { redirect_to root_url, notice: t('course.create_success')}
        #format.json { render json: @grade, status: :created, location: @grade }
      else
        #format.html { render action: "new" }
        #format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
         @course.update_user(current_user,0)
        format.html { redirect_to root_url, notice: t('operate.update_success') }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @course = Course.find(params[:id])
    @course.delete_users
    @course.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :ok }
    end
  end 
  
  def operate
    @course = Course.find(params[:id])
    case params[:by]
    when "add_teacher"

    when "remove_teacher"
      
    else
    end
    
  end
  
  
  
end
