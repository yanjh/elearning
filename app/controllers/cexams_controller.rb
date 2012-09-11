class CexamsController < ApplicationController
  # GET /
  # The default dashboard
  def index
    @course  = Course.new
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
    @cexam   = Cexam.find(params[:id])
    @problem = Problem.new
    respond_to do |format|
      format.html # edit.html.erb
    end
  end
  
  def create
    @cexam = Cexam.new(params[:cexam])

    respond_to do |format|
      if @cexam.save
        format.html { redirect_to edit_chapter_path(@cexam.chapter), notice: t('operate.create_success')}
        #format.json { render json: @grade, status: :created, location: @grade }
      else
        #format.html { render action: "new" }
        #format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @cexam = Cexam.find(params[:id])
    respond_to do |format|
      if params[:by]=="add_problem"
        problem=Problem.find_by_pcode(params[:problem])
        if problem 
          Question.create(:problem_id=>problem.id,:pcode=>problem.pcode,:cexam_id=>@cexam.id,:qorder=>1,:score=>10)
          format.html { redirect_to edit_cexam_path(@cexam), notice: t('operate.add_success') }
          #format.json { head :ok }
        else
          format.html { redirect_to edit_cexam_path(@cexam), notice: t('operate.add_false') }
        end
      elsif params[:by]=="add_question"
        problem = Problem.new(params[:problem])
        problem.owner=current_user.id
        if problem.save
          Question.create(:problem_id=>problem.id,:pcode=>problem.pcode,:cexam_id=>@cexam.id,:qorder=>1,:score=>10)
          format.html { redirect_to edit_cexam_path(@cexam), notice: t('operate.add_success') }
          #format.json { head :ok }
        else
          format.html { redirect_to edit_cexam_path(@cexam), notice: t('operate.add_false') }
        end
      elsif params[:by]=="update_problem"
        problem = Problem.find(params[:problem_id])
        if problem.update_attributes(params[:problem])
          Question.update_all({:ptype=>problem.ptype},["problem_id=?",problem.id])
          format.html { redirect_to edit_cexam_path(@cexam), notice: t('operate.add_success') }
          #format.json { head :ok }
        else
          format.html { redirect_to edit_cexam_path(@cexam), notice: t('operate.add_false') }
        end
      else
        if @cexam.update_attributes(params[:cexam])
          format.html { redirect_to course_path(@cexam.course), notice: t('operate.update_success') }
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
