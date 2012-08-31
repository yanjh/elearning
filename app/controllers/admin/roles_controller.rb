class Admin::RolesController < Admin::BaseController  
  respond_to :html, :xml, :mobile	
	
  def index
	@roles= Role.all
	@role= Role.new
    respond_with(@roles, @role)
  end
  
  def show
  	@role=Role.find(params[:id])
    respond_with(@role)
  end

  
  # POST /admin/radusers
  def create
    @role = Role.new(params[:role])
   # debugger
    respond_to do |format|
      if @role.save
        flash[:notice] = t("admin.roles.create_success")
        format.html { redirect_to(admin_roles_url) }
        format.xml  { render :xml => @role, :status => :created, :location => @role }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end  
  
  def adduser
    user= User.find_by_login(params[:search])

    @role = Role.find(params[:id])
	
	if user
		@role.users << user 
	else
        flash[:notice] = t("User_not_found")+" : "+params[:search]
	end
	
    redirect_to admin_role_path(@role)
  end

  def removeuser

    @role = Role.find(params[:id])

	if @role.id==1 && @role.users.count==1 
        flash[:notice] = t("Last_admin")
	else
    	user= User.find(params[:user_id])
		@role.users.delete(user) if user
	end

    redirect_to admin_role_path(@role)
  end


  def destroy
    @role = Role.find(params[:id])
    @role.destroy

    redirect_to admin_roles_path
  end
end
