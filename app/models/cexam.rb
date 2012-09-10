class Cexam < ActiveRecord::Base
  #has_many :questions, :order=>"ocpcode"
  belongs_to :chapter
  validate :name, :presence => true, :on => :create, :message => "can't be blank"
  
  def add_question
      
  end
  
  def remove_question
    
  end
  
end