authorization do  
  role :admin do
    has_permission_on [:admin_commits,:admin_dashboard,:admin_settings,:admin_announcements, 
                      :admin_delayed_jobs, :admin_users, :admin_roles, :admin_orgs, :admin_grades, :admin_sclasses],
    :to => [:manage,:read]
    
    has_permission_on :admin_users,
    :to => [:active, :search,:pending,:reset_password,:suspended, :activate,
            :deleted, :suspend , :unsuspend, :purge, :toggle_role, :update ]

    has_permission_on :admin_roles,
    :to => [ :adduser, :removeuser ]

    has_permission_on :admin_orgs,
    :to => [:add_class, :add_grade, :list_grade,
            :update_school,:update_grade, :update_class]
  end

  role :guest do
    
  end
end
  
privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete, :search]
  privilege :read,   :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end



