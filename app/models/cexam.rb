class Cexam < ActiveRecord::Base
  has_many :questions, :order=>"qorder"
  belongs_to :chapter
  validate :name, :presence => true, :on => :create, :message => "can't be blank"
  
  def course
      self.chapter.course
  end
  
  def remove_question
    
  end
  
end