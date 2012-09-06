class Admin::UsersController < Admin::BaseController
  
  %w(email login).each do |attr|
    in_place_edit_for :user, attr.to_sym
  end
  
  def toggle_role
    @user = User.find(params[:id])
    role = Role.find_by_name(params[:role])
    if @user.roles.include?(role)
      @user.roles.delete(role)
      flash[:notice] = t('admin.users.revoke_role', :role => role.name)
    else
      @user.roles << role
      @user.save
      flash[:notice] = t('admin.users.grant_role', :role => role.name)
    end
    if request.env["HTTP_REFERER"].present?
      redirect_to :back
    else
      redirect_to admin_user_path(@user)
    end
  end
  
  def search
    # Basic Search with pagination
    @users = User.search(params[:search], params[:page])
    render :index
  end
  
  def filter
    case params[:by]  
    when "roles"
      @users = User.role_users(params[:name]).page(params[:page])

    when "pending"  
      @users = User.paginate :conditions => {:state => 'pending'}, :page => params[:page]

    when "suspended"  
      @users = User.paginate :conditions => {:state => 'suspended'}, :page => params[:page]

    when "active"  
      @users = User.paginate :conditions => {:state => 'active'}, :page => params[:page]

    when "deleted"  
      @users = User.paginate :conditions => {:state => 'deleted'}, :page => params[:page]

    when "all"  
      @users = User.paginate :page => params[:page]

    else
      
    end
    render :action => 'index'
  end
  
  def operate
    @user = User.find(params[:id])
    case params[:by]  
    when "active"
      @user.activate!
      
    when "suspend"
      @user.suspend!
      
    when "unsuspend"
      @user.unsuspend!
      
    when "destroy"
      @user.delete
      
    when "purge"
      @user.destroy
      
    when "purgeall"
      #@user.destroy
      
    when "recovery"
      @user.set_active
    else
      
    end
    redirect_to admin_users_path
  end
  
  # DELETE /admin_users/1
  # DELETE /admin_users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.delete!

    redirect_to admin_users_path
  end

  # GET /admin_users
  # GET /admin_users.xml
  def index
    @users = User.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /admin_users/1
  # GET /admin_users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end    
  end
  
  # GET /admin_users/new
  # GET /admin_users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # POST /admin/users
  def create
    @user = User.new(params[:user])
   # debugger
    respond_to do |format|
      if @user.save
        flash[:notice] = t("admin.users.create_success");
        format.html { redirect_to(admin_user_url(@user)) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def reset_password
    @user = User.find(params[:id])
    @user.reset_password!
    
    flash[:notice] = t("admin.users.send_password_mail")
    redirect_to admin_user_path(@user)
  end
  
  def update
    @user = User.find(params[:id])
    @user.attributes = params[:user]
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to :action => :show, :id => params[:id] }
      else
        format.html { render :action => :edit }
      end
    end
  end
  
  def update_password
    @user = User.find(params[:id])
    if !@user.not_using_openid?
      flash[:notice] = "Cannot update your password with OpenID!"
      redirect_to :back
    end
    
    if @user.update_with_password(params[:user])
      redirect_to root_path, :notice => "Password updated!"
    else
     # @user.errors.each do |name ,msg| 
     #   flash[:error] = name.to_s.titleize + " " + msg
     # end
     # render :edit_password        
    end
    redirect_to admin_user_path(@user)
  end
  
end
