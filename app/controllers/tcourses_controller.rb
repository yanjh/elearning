class TcoursesController < ApplicationController
  # course controller for student GET /

  def index
    @sclass  = Sclass.find(current_user.sclass.sclass_id)
    @chapters = @sclass.chapters
  end
  
  def show
    @course = Course.find(params[:id])
    @sclass = Sclass.find(params[:sclass])
    @show = params[:by]
    case @show
    when "course"
      
    when "chapter"
      @chapter = Chapter.find(params[:chapter])
      
    when "cexam"
      @cexam = Cexam.find(params[:cexam])
    end
    
    respond_to do |format|
      format.html  # show.html.erb
      format.json { render json: @scourse }
    end
  end
end
