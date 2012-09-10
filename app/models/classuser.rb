class Classuser < ActiveRecord::Base
    #has_one :user, :class_name=>"User"
    validates_uniqueness_of :user_id, :scope => [:sclass_id,:ltype]
 
    def user
      User.find(user_id)
    end
    
    def grade
      sclass.grade
    end
    
    def sclass
      Sclass.find(self.sclass_id)
    end
    
    def s_count
      sclass.students.count
    end
    
end
