class Course < ActiveRecord::Base
  has_many :chapters
  validate :name, :presence => true, :on => :create, :message => "can't be blank"
  
  def add_chapter(chapter) 
      chapters << chapter
  end   
end