class  SclassesController < ApplicationController

  #require role
  def index

  end
  
  def show
    @sclass   = Sclass.find(params[:id])
    @course  = Course.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sclass }
    end
  end
  
  def edit
    @sclass = Sclass.find(params[:id])
  end
  
  def create
    @sclass = Sclass.new(params[:sclass])

    respond_to do |format|
      if @sclass.save
        format.html { redirect_to admin_orgs_url, notice: t('admin.orgs.create_class_success')}
        #format.json { render json: @grade, status: :created, location: @grade }
      else
        format.html { render action: "new" }
        #format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @sclass = Sclass.find(params[:id])
    respond_to do |format|
    if params[:by]=="repair"
      @sclass.repair_users
      format.html { redirect_to admin_orgs_url, notice: t('g.o_s') }
    elsif params[:by]=="add_course1"
      course=Course.find(params[:course])
      if course 
        @sclass.add_course(course)
        format.html { redirect_to courses_url, notice: t('g.a_s') }
        format.js { render "course1" }
        #format.json { head :ok }
      else
        format.html { redirect_to courses_url, notice: t('g.a_f') }
      end
    else
      if @sclass.update_attributes(params[:sclass])
        format.html { redirect_to admin_orgs_url, notice: t('g.u_s') }
        format.json { head :ok }
      else
        format.html { render action: "edit_class" }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
    end
  end
    
  def destroy
    @sclass = Sclass.find(params[:id])
    respond_to do |format|
    if params[:by]=="remove_course"
      @sclass.remove_course(params[:course_id])
      format.html { redirect_to sclass_url(@sclass), notice: t('g.r_s') }
      format.json { head :ok }
    elsif params[:by]=="remove_course1"
      @sclass.remove_course(params[:course])
      format.html { redirect_to courses_url }
      format.json { head :ok }
      format.js { render "course1" }
    elsif params[:by]=="remove_teacher"
      @sclass.remove_user(params[:user_id],1)
      format.html { redirect_to sclass_url(@sclass), notice: t('g.r_s') }
    else
    
    end
    end
  end
    
end
