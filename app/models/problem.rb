class Problem < ActiveRecord::Base
  #has_many :questions, :order=>"ocpcode"
  validate :pcode,   :presence => true, :on => :create, :message => "can't be blank"
  validate :content, :presence => true, :on => :create, :message => "can't be blank"
  
end