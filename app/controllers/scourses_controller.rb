class ScoursesController < ApplicationController
  # course controller for student GET /

  def index
    @sclass  = Sclass.find(current_user.sclass.sclass_id)
    @chapters = @sclass.chapters
  end
  
  def show
    if (params[:by]=="chapter")
      @scourse  = Mlink.one(params[:id],current_user.id,Mlink::T_CHAPTER_USER )
    elsif (params[:by]=="cexam")
      @scourse  = Mlink.one(params[:id],current_user.id,Mlink::T_CEXAM_USER )
    else
      @scourse  = Mlink.find(params[:id])
    end
    
    respond_to do |format|
      if @scourse.ltype==Mlink::T_CHAPTER_USER
        @chapter = Chapter.find(@scourse.id1)
        @title = t("chapter.title")
      else
        @title = t("exam.title")
        @cexam = Cexam.find(@scourse.id1)
      end
    
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
    respond_to do |format|
      if params[:by]=="update_exam"
        @cexam=Cexam.find(params[:id])
        
        teacher=User.find_by_login(params[:teacher])
        if teacher && (teacher.id!=current_user.id)
          @course.add_user(teacher,1)
          format.html { redirect_to course_url, notice: t('operate.add_success') }
          #format.json { head :ok }
        else
          format.html { redirect_to course_url, notice: t('operate.add_false') }
        end
      elsif params[:by]=="cexam"
        sclass=Sclass.find_by_name(params[:sclass])
        if sclass 
          @course.add_class(sclass)
          format.html { redirect_to course_url, notice: t('operate.add_success') }
          #format.json { head :ok }
        else
          format.html { redirect_to course_url, notice: t('operate.add_false') }
        end
      else
        if @course.update_attributes(params[:course])
           @course.update_user(current_user,0)
          format.html { redirect_to root_url, notice: t('operate.update_success') }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          #format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
  def destroy
    @course = Course.find(params[:id])

    respond_to do |format|
      if params[:by]=="remove_teacher"
        teacher=User.find(params[:teacher])
        @course.remove_user(teacher)
        format.html { redirect_to @course }
        format.json { head :ok }
      elsif params[:by]=="remove_class"
        sclass=Sclass.find(params[:sclass])
        @course.remove_class(sclass)
        format.html { redirect_to @course }
        format.json { head :ok }
      else
        @course.delete_users
        @course.destroy
        format.html { redirect_to root_url }
        format.json { head :ok }
      end
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
