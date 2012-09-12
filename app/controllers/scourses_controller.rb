class ScoursesController < ApplicationController
  # course controller for student GET /

  def index
    @sclass  = Sclass.find(current_user.sclass.sclass_id)
    @chapters = @sclass.chapters
  end
  
  def show
    @course  = Course.find(params[:id])
    @chapter = Chapter.new(:course_id=>params[:id])
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
      if params[:by]=="add_teacher"
        teacher=User.find_by_login(params[:teacher])
        if teacher && (teacher.id!=current_user.id)
          @course.add_user(teacher,1)
          format.html { redirect_to course_url, notice: t('operate.add_success') }
          #format.json { head :ok }
        else
          format.html { redirect_to course_url, notice: t('operate.add_false') }
        end
      elsif params[:by]=="add_class"
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