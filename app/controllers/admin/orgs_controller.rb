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
    @grades = Grade.where(" id>?",1).order(" gyear")
    @grade = Grade.new;
    @sclass= Sclass.new;
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
  
end