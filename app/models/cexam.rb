class Cexam < ActiveRecord::Base
  has_many :questions, :order=>"qorder"
  belongs_to :chapter
  validate :name, :presence => true, :on => :create, :message => "can't be blank"
  
  def course
      self.chapter.course
  end
  
  def remove_question
    
  end
  
  def user_status(user_id)
    s=Mlink.one(self.id,user_id,Mlink::T_CEXAM_USER)
    (s.nil?)?0:s.status
  end
  
end