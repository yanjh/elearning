class Ipad::TcoursesController <  Ipad::BaseController
  # course controller for student GET /
  
  def index
    respond_to do |format|
      if params[:show]=="setting"
        format.js { render "setting" }
      elsif params[:show]=="course"
        format.js { render "course" }
      elsif params[:show]=="course2"
        @sclass=current_user.sclass
        format.js { render "course2" }
      elsif params[:show]=="chapter"
        @chapter=Chapter.find(params[:chapter])
        @path_root=configatron.chapter_root+@chapter.id.to_s+"/"
        format.js { render "chapter" }
      elsif params[:show]=="cexam"
        @cexam=Cexam.find(params[:cexam])
        format.js { render "cexam" }
      end 
    end
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
