class Course < ActiveRecord::Base
  has_many :chapters
  validate :name, :presence => true, :on => :create, :message => "can't be blank"
  
  def add_chapter(chapter) 
      chapters << chapter
  end
  
  def add_user(user,link_type)
    Courseuser.create(:course_id=>self.id,:coursename=>self.title,:link_id=>user.id,:linkname=>user.name,:ltype=>link_type)
  end
end