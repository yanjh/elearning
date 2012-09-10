Rails3::Application.routes.draw do
  root :to => "dashboard#index"

  devise_for  :users,
              :controllers => { :sessions => "user_sessions" },
              :path_names => { :sign_in => 'login', :sign_out => 'logout',  :registration => 'register' }

  # The priority is based upon order of creation:
  # first created -> highest priority.
  resources :profiles,:sclasses,:courses,:chapters,:cexams,:questions,:announcements

  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create', :as => :auth_callback
  
  # RESTful rewrites
  match  '/opensession' => "sessions#create", :as => "open_id_complete", :requirements => { :method => :get }
  match '/opencreate' => 'users#create',:as => :open_id_create,  :requirements => { :method => :get }

  resources :users do
     member do
       get :edit_password 
       get :set_login
       put :update_login
       put :update_password
       get :edit_email
       put :update_email
       get :edit_avatar
       put :update_avatar
    end
  end
    
  
  # Administration
  namespace :admin do 
    root :to => 'dashboard#index'
    match '/settings/update_settings' => 'settings#update_settings',  :requirements => { :method => :post }
#    match '/users/search' => 'users#search',  :requirements => { :method => :get }

    resources :announcements
    resources :commits
    resources :delayed_jobs, :only => [:index]
    resources :settings 
    
    resources :users do 
      member do 
        put :operate
        put :reset_password
        put :update_password
        get :set_user_login
        get :set_user_email
        post :addrole
        delete :removerole
        match 'role/:role' => "users#toggle_role", :as => "toggle_role"
      end
      collection do
        get :search
        get :filter
      end
    end
    
    resources :roles do
      member do 
        post :adduser
        delete :removeuser
	  end 
  	end

    resources :orgs do
      collection do
        get  :edit_school
        post :update_school
      end

    end

    resources :grades
    
    resources :sclasses do
      member do
		put  :operate
        post :add_student
        post :add_teacher
	  end 
    end
  end
  
end
