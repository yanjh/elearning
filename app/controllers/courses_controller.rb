class CoursesController < ApplicationController
  # GET /
  # The default dashboard
  def index
    if current_user.teacher?
      @course  = Course.new
      @courses = current_user.courses
      render "t_dashboard"
    else
      
    end
    
  end
  
  def show
    @course = params[:id]
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sclass }
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
  
  
end
