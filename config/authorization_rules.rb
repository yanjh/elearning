authorization do  
  role :admin do
    has_permission_on [:admin_commits,:admin_dashboard,:admin_settings,:admin_announcements, 
                      :admin_delayed_jobs, :admin_users, :admin_roles, :admin_orgs, :admin_grades, :admin_sclasses],
    :to => [:manage,:read]
    
    has_permission_on :admin_users,
    :to => [:pending,:reset_password,:suspended, :activate,:deleted, :toggle_role, :update_password ]

    has_permission_on :admin_roles,
    :to => [ :adduser, :removeuser ]

    has_permission_on :admin_orgs,
    :to => [:add_class, :add_grade, :list_grade,
            :update_school,:update_grade, :update_class]

    has_permission_on :admin_sclasses,
    :to => [:add_student, :add_teacher, :remove_user]
  end
  
  role :teacher do
    has_permission_on [:ipad_dashboard,:ipad_tcourses,:tcourses, :sclasses, :courses, :chapters, :cexams, :questions, :problems],
    :to => [:manage,:read]
    
  end
  
  role :student do
    has_permission_on [:ipad_dashboard,:ipad_scourses,:scourses, :schapters, :schapters, :scexams, :questions, :problems],
    :to => [:manage,:read]
  end
  
  role :guest do
    has_permission_on [:ipad_dashboard], :to => [:index]
  end
end
  
privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete, :operate ]
  privilege :read,   :includes => [:index,  :show, :filter, :search]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end



