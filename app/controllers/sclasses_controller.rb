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
    if params[:by]=="remove_course"
      @sclass.remove_course(params[:course_id])
      format.html { redirect_to sclass_url(@sclass), notice: t('operate.remove_success') }
      format.json { head :ok }
    else
      if @sclass.update_attributes(params[:sclass])
        format.html { redirect_to admin_orgs_url, notice: t('operate.update_success') }
        format.json { head :ok }
      else
        format.html { render action: "edit_class" }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
    end
  end
  
  def add_student
    @sclass= Sclass.find(params[:id])

    @student = User.find_by_login(params[:user][:login])
    if @student.nil?
      params[:user][:password]="hello123"
      params[:user][:password_confirmation]="hello123"
      params[:user][:language]="cn"
      params[:user][:email]=params[:user][:login]+"@yucai.cn"
      
      @student = User.new(params[:user])
    end

    respond_to do |format|
      if @student.save
        logger.debug 'save student info'
        @sclass.add_user(@student,1)
        format.html { redirect_to admin_sclass_url(@sclass), notice: t('admin.orgs.add_student_success')}
        #format.json { render json: @grade, status: :created, location: @grade }
      else
        logger.debug 'save student false'
        format.html { redirect_to admin_sclass_url(@sclass), notice: t('admin.orgs.add_student_false')}
        #format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def operate
    @sclass= Sclass.find(params[:id])
    case params[:by]
    when "add_teacher"
      
    when "add_student"
      
    when "remove_teacher"
      @sclass.remove_user(params[:user_id],0)
      notice_info=t('admin.orgs.remove_teacher_success')
            
    when "remove_student"
      @sclass.remove_user(params[:user_id],1)
      notice_info=t('admin.orgs.remove_student_success')

    when "repair"
      @sclass.repair_users
      notice_info=t('admin.orgs.data_repair_success')
    else      
      
    end
    

    respond_to do |format|
      format.html { redirect_to admin_sclass_url(@sclass), notice: notice_info}
      #format.json { render json: @grade, status: :created, location: @grade }
    end
    
  end
  
  def remove_teacher
    
  end
  
end
