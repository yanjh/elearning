class Chapter < ActiveRecord::Base
  belongs_to :course
  has_many :chapterclass
  has_many :cexams
  
  validate :name, :presence => true, :on => :create, :message => "can't be blank"
  
  def add_to_course(course)
    course.chapters << self  
  end
  
  def sclasses
    Chapterclass.where(:chapter_id=>self.id)
  end
  
  def add_class(sclass)
    Chapterclass.create(:chapter_id=>self.id,:chaptername=>self.title,:link_id=>sclass.id,:linkname=>sclass.name)  
  end

  def remove_class(sclass)
    Chapterclass.delete_all(:chapter_id=>self.id,:link_id=>sclass.id)  
  end
  
  def user_status(user_id)
    s=Mlink.one(self.id,user_id,Mlink::T_CHAPTER_USER)
    (s.nil?)?0:s.status
  end
  
end