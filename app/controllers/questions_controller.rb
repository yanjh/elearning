class QuestionsController < ApplicationController
  
  def create
    @chapter = Chapter.new(params[:chapter])
    @course=@chapter.course
    respond_to do |format|
      if @chapter.save
        format.html { redirect_to @course, notice: t('operate.create_success')}
        #format.json { render json: @grade, status: :created, location: @grade }
      else
        format.html { redirect_to @course, notice: t('operate.create_false')}
        #format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @question = Question.find(params[:id])
    @problem = @question.problem
    @cexam=@question.cexam
    respond_to do |format|
      format.html # edit.html.erb
    end
  end
  
  def update
    @question = Question.find(params[:id])
    
    respond_to do |format|

      if @question.update_attributes(params[:question])
          format.html { redirect_to edit_cexam_path(@question.cexam), notice: t('operate.update_success') }
          format.json { head :ok }
      else
          format.html { render action: "edit" }
          #format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @question = Question.find(params[:id])
    respond_to do |format|
      @cexam  =@question.cexam
      @question.destroy
      format.html { redirect_to edit_cexam_path(@cexam) }
      format.json { head :ok }
    end
  end
 
end
