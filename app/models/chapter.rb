class Chapter < ActiveRecord::Base
  belongs_to :course
  validate :name, :presence => true, :on => :create, :message => "can't be blank"
  
  def add_to_course(course)
    course.chapters << self  
  end
end