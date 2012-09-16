class Course < ActiveRecord::Base
  has_many :chapters, :order=>"cpcode"
  validate :name, :presence => true, :on => :create, :message => "can't be blank"
  
  def add_chapter(chapter) 
      chapters << chapter
  end
  
  def add_teacher(user,linktype)
    Mlink.create(:id1=>self.id,:name1=>self.title,:order1=>self.ccode,:id2=>user.id,:name2=>user.name,:ltype=>linktype)
  end

  def add_class(sclass)
    Mlink.create(:id1=>self.id,:name1=>self.title,:order1=>self.ccode,:id2=>sclass.id,:name2=>sclass.name,:order2=>sclass.name,:ltype=>Mlink::T_COURSE_CLASS)
  end
  
  def update_teacher(user)
    Mlink.where(:id1 =>self.id,:id2 => user.id, :ltype=>Mlink::T_COURSE_AID).first.update_attributes(:name1=>self.title,:name2=>user.name)
  end

  def update_class(sclass)
    Mlink.where(:id1 =>self.id,:id2 => user.id, :ltype=>Mlink::T_COURSE_CLASS).first.update_attributes(:name1=>self.title,:name2=>sclass.name)
  end
  
  def delete_users
    Mlink.delete_all(:id1=>self.id)
  end
  
  def remove_teacher(user)
    Mlink.delete_all(:id1=>self.id,:id2=>user.id,:ltype=>Mlink::T_COURSE_AID)
  end
  
  def remove_class(sclass)
    Mlink.delete_all(:id1=>self.id,:id2=>sclass.id,:ltype=>Mlink::T_COURSE_CLASS)
  end
  
  def teachers
    Mlink.where(" id1=?  and (ltype=? or ltype=?) ",self.id,Mlink::T_COURSE_TEACHER,Mlink::T_COURSE_AID)
  end
  
  def sclasses
    Mlink.where(" id1=? and ltype=?",self.id,Mlink::T_COURSE_CLASS).order("name2")
  end 
  
end