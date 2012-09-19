class UserSessionsController < Devise::SessionsController
    def create
      if params[:for]=="ipad"
		url_go = ipad_root_url
      elsif params[:for]=="admin"
		url_go = admin_root_url
      else
        url_go = root_url
      end
      
      resource = warden.authenticate(auth_options)
      set_flash_message(:notice, :signed_in) if is_navigational_format?
      sign_in(resource_name, resource) if resource
      #respond_with resource, :location => after_sign_in_path_for(resource)
      respond_to do |format|
        format.any(*navigational_formats) { redirect_to url_go }
        format.all do
          head :no_content
        end
      end 
    end
    
    def destroy #rewrite destroy
      if params[:for]=="ipad"
		redirect_path = ipad_root_url
      elsif params[:for]=="admin"
		redirect_path = admin_root_url
      else
        redirect_path = root_url
      end
      
      #redirect_path = after_sign_out_path_for(resource_name)
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      set_flash_message :notice, :signed_out if signed_out && is_navigational_format?
  
      # We actually need to hardcode this as Rails default responder doesn't
      # support returning empty response on GET request
      respond_to do |format|
        format.any(*navigational_formats) { redirect_to redirect_path }
        format.all do
          head :no_content
        end
      end      
    end
end
