class UserSessionsController < Devise::SessionsController
    def create
      if params[:for]=="ipad"
		session['user_return_to'] = ipad_root_url
      elsif params[:for]=="admin"
		session['user_return_to'] = admin_root_url
      else
        session['user_return_to'] = root_url
      end
      
      super            
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
