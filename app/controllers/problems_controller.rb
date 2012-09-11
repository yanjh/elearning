class ProblemsController < ApplicationController
  
  def create
    @problem = Problem.new(params[:problem])

    respond_to do |format|
      if @problem.save
        if params[:cexam_id]
          cexam_id=params[:cexam_id]
          @question=Question.create(:problem_id=>@problem.id,:pcode=>@problem.pcode,:cexam_id=>cexam_id,:qorder=>@problem.id)
          format.html { redirect_to edit_cexam_path(cexam_id), notice: t('operate.create_success')}
        else
          format.html { redirect_to problems_path, notice: t('operate.create_success')}
          
        end
        #format.json { render json: @grade, status: :created, location: @grade }
      else
        format.html { redirect_to :back, notice: t('operate.create_false')}
        #format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @chapter = Chapter.find(params[:id])
    @cexam= Cexam.new(:chapter_id=>@chapter.id)
    respond_to do |format|
      format.html # edit.html.erb
    end
  end
  
  def update
    @chapter = Chapter.find(params[:id])
    
    respond_to do |format|
      if params[:by]=="add_class"
        sclass=Sclass.find(params[:sclass])
        if sclass 
          @chapter.add_class(sclass)
          format.html { redirect_to @chapter.course, notice: t('operate.add_success') }
          #format.json { head :ok }
        else
          format.html { redirect_to @chapter.course, notice: t('operate.add_false') }
        end
      elsif params[:by]=="remove_class"
        sclass=Sclass.find(params[:sclass])
        if sclass 
          @chapter.remove_class(sclass)
          format.html { redirect_to @chapter.course, notice: t('operate.remove_success') }
          #format.json { head :ok }
        else
          format.html { redirect_to @chapter.course, notice: t('operate.remove_false') }
        end
      else
        if @chapter.update_attributes(params[:chapter])
          format.html { redirect_to course_path(@chapter.course), notice: t('operate.update_success') }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          #format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
  def destroy
    @chapter = Chapter.find(params[:id])
    respond_to do |format|
      @course  =@chapter.course
      @chapter.destroy
      format.html { redirect_to @course }
      format.json { head :ok }
    end
  end
 
end
