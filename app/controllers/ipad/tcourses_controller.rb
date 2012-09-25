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
    case params[:show] 
      when "course"
        format.html {render "_show_course"} # respond to Ajax request
        
      when "chapter"
        @chapter = Chapter.find(params[:chapter])
        @position=1
        @image=configatron.chapter_root+@chapter.id.to_s+"/"+@position.to_s.rjust(3,'0')+".jpg"
        format.js { render "chapter" }
        
      when "nav_img"
        @chapter = Chapter.find(params[:chapter])
        @position=params[:position].to_i
        logger.debug("--------------position: #{@position}")
        if params[:direct]=="home"
          @position =1 
        elsif params[:direct]=="next"
          @position += 1
        else
          @position -= 1 if @position>1
        end 
        @image=configatron.chapter_root+@chapter.id.to_s+"/"+@position.to_s.rjust(3,'0')+".jpg"
        
        format.js { render "position" }
      when "cexam"
        @cexam = Cexam.find(params[:cexam])
        format.html {render "_show_cexam"} # respond to Ajax request
    end
    end
  end
end
