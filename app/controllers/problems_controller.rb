class ProblemsController < ApplicationController
  def index
    if (params[:operate]=="filter")
      case params[:by]
      when "all"
        @problems = Problem.where("owner=? or status=0",current_user.id).order("updated_at desc").page(params[:page])
      when "public"
        @problems = Problem.where("owner=? and status=0",current_user.id).order("updated_at desc").page(params[:page])
      when "private"
        @problems = Problem.where("owner=? and status=1",current_user.id).order("updated_at desc").page(params[:page])
      when "close"
        @problems = Problem.where("owner=? and status=2",current_user.id).order("updated_at desc").page(params[:page])
      when "ctype"
        @problems = Problem.where("(owner=? or status=0) and ctype=?",current_user.id,params[:type]).order("updated_at desc").page(params[:page])
      when "ptype"
        @problems = Problem.where("(owner=? or status=0) and ptype=?",current_user.id,params[:type]).order("updated_at desc").page(params[:page])
      end
    else
      @problems= Problem.user_problems(current_user.id).page(params[:page])
    end
    
    @problem = Problem.new(:pcode=>[*('A'..'Z')].sample+rand(36**5).to_s(36))
    
  end
  
  def edit
    @problem= Problem.find(params[:id])    
  end
  
  def create
    @problem = Problem.new(params[:problem])
    @problem.owner=current_user.id
    @problem.ownername=current_user.name

    respond_to do |format|
      if @problem.save
          format.html { redirect_to problems_path, notice: t('operate.create_success')}
          
      else
        format.html { redirect_to :back, notice: t('operate.create_false')}
        #format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @problem = Problem.find(params[:id])
    
    respond_to do |format|
      if @problem.update_attributes(params[:problem],:owner=>current_user.id,:ownername=>current_user.name)
        format.html { redirect_to problems_path, notice: t('operate.update_success') }
        #format.json { head :ok }
      else
        format.html { render action: "edit" }
        #format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @problem = Problem.find(params[:id])
    respond_to do |format|
      @problem.delete
      format.html { redirect_to problems_path }
      format.json { head :ok }
    end
  end
 
end
