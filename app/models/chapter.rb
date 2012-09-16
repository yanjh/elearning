class Chapter < ActiveRecord::Base
  belongs_to :course
  has_many :chapterclass
  has_many :cexams
  
  validate :name, :presence => true, :on => :create, :message => "can't be blank"
  
  def add_to_course(course)
    course.chapters << self  
  end
  
  def sclasses
    Mlink.where("id1=? and ltype=?",self.id, Mlink::T_CHAPTER_CLASS)
  end
  
  def add_class(sclass)
    Mlink.create(:ltype=>Mlink::T_CHAPTER_CLASS,:id1=>self.id,:name1=>self.title,:order1=>self.cpcode,:id2=>sclass.id,:name2=>sclass.name,:order2=>sclass.name)  
  end

  def remove_class(sclass)
    Mlink.delete_all(["id1=? and id2=? and ltype=?",self.id,sclass.id,Mlink::T_CHAPTER_CLASS])  
  end
  
  def user_status(user_id)
    Mlink.one(self.id,user_id,Mlink::T_CHAPTER_USER)
  end
  
  def finish(user_id)
    cu=Mlink.one(self.id,user_id,Mlink::T_CHAPTER_USER)
    if cu
      cu.update_attributes(:status=>2)
    else
      false
    end
  end 
end