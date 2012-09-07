class Courseuser < ActiveRecord::Base
    #has_one :user, :class_name=>"User"
    validates_uniqueness_of :course_id, :scope => [:link_id,:ltype]
 
    def users
      #User.find(link_id) if self.ltype==0
    end
    
    def sclasses
      #User.find(link_id) if self.ltype==0
    end
    
    def course
      Course.find(self.course_id, :order => "ccode")
    end
    
end
