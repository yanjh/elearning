class  Admin::SclassesController < Admin::BaseController  

  def index

  end
  
  def show
    @sclass  = Sclass.find(params[:id])
    @student = User.new

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
  
  
end
