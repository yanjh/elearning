class Admin::OrgsController < Admin::BaseController  
  def index
    begin
      @school = Grade.find(1);
    rescue
      @school= Grade.new
      @school[:id]=1;
      @school[:name]=configatron.school_name;
      @school[:description]=configatron.school_desc;
      @school.save!;
    ensure 
      #  this_code_is_always_executed
    end
    @grade = Grade.new;
    @sclass= Grade.new;
  end
  
  def edit_school
    @school = Grade.find(1);
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @grade }
    end
  end

    # PUT /grades/1
  # PUT /grades/1.json
  def update_school
    @school = Grade.find(1)

    respond_to do |format|
      if @school.update_attributes(params[:grade])
        format.html { redirect_to admin_orgs_url, notice: t("admin.orgs.update_school_success") }
        format.json { head :ok }
      else
       # format.html { render action: "edit_school" }
       # format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  def list_grade
    @school_name= Grade.find(1).name
    @grades = Grade.where(" id>?",1).order(" gyear")
    @sclass =  Grade.new;
    @grade  =  Grade.new;

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @grade }
    end
  end
  
  def list_class
    @classes = SClass.all

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @grade }
    end
  end
  
    # POST /grades
  # POST /grades.json
  def create
    @grade = Grade.new(params[:grade])

    respond_to do |format|
      if @grade.save
        format.html { redirect_to list_grade_admin_orgs_url, notice: t('admin.orgs.create_grade_success') }
        #format.json { render json: @grade, status: :created, location: @grade }
      else
        format.html { render action: "new" }
        #format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /grades/1/edit
  def edit
    @grade  = Grade.find(params[:id])
    @sclass = Grade.find(params[:id])
  end
  
  # PUT /grades/1
  # PUT /grades/1.json
  def update
    @grade = Grade.find(params[:id])

    respond_to do |format|
      if @grade.update_attributes(params[:grade])
        format.html { redirect_to list_grade_admin_orgs_url, notice: t('admin.orgs.update_grade_success') }
        #format.json { head :ok }
      else
        format.html { render action: "edit" }
        #format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  
end