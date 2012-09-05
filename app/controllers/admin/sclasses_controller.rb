class  Admin::SclassesController < Admin::BaseController

  #require role
  
  def index

  end
  
  def show
    @sclass  = Sclass.find(params[:id])
    @students = User.new
    @student  = User.new

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
  
    # PUT /grades/1
  # PUT /grades/1.json
  def update
    @sclass = Sclass.find(params[:id])

    respond_to do |format|
      if @sclass.update_attributes(params[:sclass])
        format.html { redirect_to admin_orgs_url, notice: t('admin.orgs.update_class_success') }
        format.json { head :ok }
      else
        format.html { render action: "edit_class" }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def add_student
    @sclass= Sclass.find(params[:id])

    @student = User.find_by_name(params[:user][:name])
    if @student.nil?
      params[:user][:password]="hello123"
      params[:user][:password_confirmation]="hello123"
      params[:user][:language]="cn"
      params[:user][:email]=params[:user][:name]+"@yucai.cn"
      
      @student = User.new(params[:user])
    end

    respond_to do |format|
      if @student.save
        logger.debug 'save student info'
        @sclass.add_student(@student)
        format.html { redirect_to admin_sclass_url(@sclass), notice: t('admin.orgs.add_student_success')}
        #format.json { render json: @grade, status: :created, location: @grade }
      else
        logger.debug 'save student false'
        format.html { redirect_to admin_sclass_url(@sclass), notice: t('admin.orgs.add_student_false')}
        #format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end
end
