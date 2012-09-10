class DashboardController < ApplicationController
  # GET /
  # The default dashboard
  def index
    @course= Course.new
    render "t_dashboard"
  end
  
  def create
    @course  = Course.find(params[:id])
    @chapter = Chapter.new(params[:chapter])

    respond_to do |format|
      if @chapter.save
        @course.chapters << chapter
        format.html { redirect_to course_url(@course), notice: t('operate.create_success')}
        #format.json { render json: @grade, status: :created, location: @grade }
      else
        format.html { redirect_to course_url(@course), notice: t('operate.create_false')}
        #format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end    
end
