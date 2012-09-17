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

    def failure      
        redirect_to root_url
    end
    
    def destroy
      if params[:for]=="ipad"
		session['user_return_to'] = ipad_root_url
      elsif params[:for]=="admin"
		session['user_return_to'] = admin_root_url
      else
        session['user_return_to'] = root_url
      end

      super
      
    end
end
