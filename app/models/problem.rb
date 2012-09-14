class Problem < ActiveRecord::Base
  #has_many :questions, :order=>"ocpcode"
  validate :pcode,   :presence => true, :on => :create, :message => "can't be blank"
  validate :content, :presence => true, :on => :create, :message => "can't be blank"
  
  def self.user_problems(user_id)    
    Problem.where("owner =? or status=0",user_id)
  end
  
end