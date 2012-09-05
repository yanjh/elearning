#require 'aasm_roles'
class Sclass < ActiveRecord::Base
#  include AasmRoles
  
  validate :name, :presence => true, :on => :create, :message =>'phrase.cant_blank'

  belongs_to :grade
  
  def teachers
    Classuser.where("sclass_id=? and ltype=0",self.id).joins("LEFT OUTER JOIN users ON users.id = user_id")
  end
  
  def students
    Classuser.where("sclass_id=? and ltype=1",self.id).joins("LEFT OUTER JOIN users ON users.id = user_id")
    #Classuser.all(:include => :user, :conditions => {:sclass_id=>self.id,:ltype=>1})  
  end
  
  def add_teacher(user)
    user.add_role("teacher")
    cuser=Classuser.new(:sclass_id=>self.id, :user_id=>user.id, :username=>user.name,:ltype=>0)
    cuser.save!
  end
   
  def add_student(user)
    user.add_role("student")
    cuser=Classuser.new(:sclass_id=>self.id, :user_id=>user.id, :username=>user.name,:ltype=>1)
    cuser.save!
  end
end
