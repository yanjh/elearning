class Ipad::ScoursesController < Ipad::BaseController
  # course controller for student GET /

  def index
    respond_to do |format|
      if params[:show]=="setting"
        format.js { render "setting" }
      elsif params[:show]=="course"
        format.js { render "course" }
      end 
    end
  end
  
  def show
    @show=params[:by]
    if (@show=="gc" or @show=="vc")
      @scourse  = Mlink.one(params[:id],current_user.id,Mlink::T_CHAPTER_USER )
      @chapter = Chapter.find(@scourse.id1)
      @title = t("chapter.title")      
    elsif (@show=="ge" or @show=="ve")
      @title = t("exam.title")
      @scourse  = Mlink.one(params[:id],current_user.id,Mlink::T_CEXAM_USER )
      @cexam = Cexam.find(@scourse.id1)
    end
    
    respond_to do |format|    
      format.html  # show.html.erb
      format.json { render json: @scourse }
    end
  end
  
  def edit
    @course = Course.find(params[:id])
    
    respond_to do |format|
      format.html # edit.html.erb
    end
  end
  
  def create    
    respond_to do |format|
      if (params[:by]=="chapter")
        chapter = Chapter.find(params[:id])
        if @scourse = Mlink.create(:id1=>chapter.id,:name1=>chapter.title,:order1=>chapter.cpcode,:id2=>current_user.id,:name2=>current_user.name,:order2=>current_user.login,:ltype=>Mlink::T_CHAPTER_USER,:status=>1)
          format.html { redirect_to scourse_url(@scourse), notice: t('operate.create_success')}
          #format.json { render json: @grade, status: :created, location: @grade }
        else
          #format.html { render action: "new" }
          #format.json { render json: @grade.errors, status: :unprocessable_entity }
        end
      elsif (params[:by]=="cexam")
        cexam = Cexam.find(params[:id])
        if @scourse = Mlink.create(:id1=>cexam.id,:name1=>cexam.name,:order1=>cexam.id,:id2=>current_user.id,:name2=>current_user.name,:order2=>current_user.login,:ltype=>Mlink::T_CEXAM_USER,:status=>1)
          format.html { redirect_to scourse_url(@scourse), notice: t('operate.create_success')}
          #format.json { render json: @grade, status: :created, location: @grade }
        else
          #format.html { render action: "new" }
          #format.json { render json: @grade.errors, status: :unprocessable_entity }
        end
      
      else
    
      end
    end
  end
  
  def update
    #@course = Course.find(params[:id])
    user_id=current_user.id
    respond_to do |format|
      if params[:by]=="update_exam" #update
        scourse_id=params[:id]
        cexam=Cexam.find(params[:cexam])
        for question in cexam.questions
          aw=params["a_"+question.id.to_s]
          #logger.debug "answer:"+answer if answer
          
          sq=Sqresult.one(user_id,question.id)
          if aw
            if aw.kind_of?(Array)
              answer=aw.map {|s| s }.join
            else
              answer=aw
            end
            
            if sq
              sq.update_attributes(:answer=>answer)
            else
              sq=Sqresult.create(:student_id=>user_id,:question_id=>question.id,:answer=>answer,:qorder=>question.qorder)
            end
          else
            sq.delete if sq
          end
        end
        
        if params[:commit]==t("g.finish")
          snotice=(cexam.finish(current_user.id))?t('g.u_s'):t('g.u_f')
          format.html { redirect_to scourses_url, notice: snotice }
        else
          format.html { redirect_to scourse_url(cexam.id,:by=>"ge"), notice: t('g.u_s') }
        end
          #format.json { head :ok }
      elsif (params[:by]=="fc") #finish chapter
        cu=Mlink.one(params[:id],current_user.id,Mlink::T_CHAPTER_USER)
        if cu && cu.update_attributes(:status=>2)
          format.html { redirect_to scourses_url, notice: t('g.o_s')}
        else
          format.html { redirect_to scourses_url, notice: t('g.o_f')}
        end
      
      elsif (params[:by]=="fe") #finish exam
        eu=Mlink.one(params[:id],current_user.id,Mlink::T_CEXAM_USER)
        if eu && eu.update_attributes(:status=>2)
          format.html { redirect_to scourses_url, notice: t('g.o_s')}
        else
          format.html { redirect_to scourses_url, notice: t('g.o_f')}
        end
      end
    end
  end
end
