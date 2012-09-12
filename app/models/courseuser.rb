class Courseuser < ActiveRecord::Base
  
    # ltype: 0-main teacher 1-aid 2-class
    #has_one :user, :class_name=>"User"
    validates_uniqueness_of :course_id, :scope => [:link_id,:ltype]
 
    def users
      #User.find(link_id) if self.ltype==0
    end
    
    def sclasses
      Courseuser.where(:course_id=>self.course_id,:ltype=>2).order(:linkname)
    end
    
    def course
      Course.find(self.course_id, :order => "ccode")
    end
    
end
