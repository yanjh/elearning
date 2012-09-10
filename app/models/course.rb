class Course < ActiveRecord::Base
  has_many :chapters
  validate :name, :presence => true, :on => :create, :message => "can't be blank"
  
  def add_chapter(chapter) 
      chapters << chapter
  end
  
  def add_user(user,link_type)
    Courseuser.create(:course_id=>self.id,:coursename=>self.title,:link_id=>user.id,:linkname=>user.name,:ltype=>link_type,:onumber=>self.ccode)
  end

  def add_class(sclass)
    Courseuser.create(:course_id=>self.id,:coursename=>self.title,:link_id=>sclass.id,:linkname=>sclass.name,:ltype=>2,:onumber=>self.ccode)
  end
  
  def update_user(user,link_type)
    Courseuser.where(:course_id =>self.id,:link_id => user.id, :ltype=>link_type).first.update_attributes(:coursename=>self.title,:linkname=>user.name,:onumber=>self.ccode)
  end
  
  def delete_users
    Courseuser.delete_all(:course_id=>self.id)
  end
  
  def remove_user(user)
    Courseuser.delete_all(:course_id=>self.id,:link_id=>user.id)
  end
  
  def remove_class(sclass)
    Courseuser.delete_all(:course_id=>self.id,:link_id=>sclass.id,:ltype=>2)
  end
  
  def teachers
    Courseuser.where("(ltype=0 or ltype=1) and course_id=?",self.id)
  end
  
  def sclasses
    Courseuser.where(" ltype=2 and course_id=?",self.id)
  end 
  
end