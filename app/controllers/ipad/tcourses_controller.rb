class Ipad::TcoursesController <  Ipad::BaseController
  # course controller for student GET /
  
  def index
    @sclass  = Sclass.find(current_user.sclass.sclass_id)
    @chapters = @sclass.chapters
  end
  
  def show
    @course = Course.find(params[:id])
    @sclass = Sclass.find(params[:sclass])
    respond_to do |format|
    case params[:by] 
      when "course"
        format.html {render "_show_course"} # respond to Ajax request
        
      when "chapter"
        @chapter = Chapter.find(params[:chapter])
        format.html {render "_show_chapter"} # respond to Ajax request
        
      when "cexam"
        @cexam = Cexam.find(params[:cexam])
        format.html {render "_show_cexam"} # respond to Ajax request
    end
    end
  end
end
