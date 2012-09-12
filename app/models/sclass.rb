#require 'aasm_roles'
class Sclass < ActiveRecord::Base
#  include AasmRoles
  
  validate :name, :presence => true, :on => :create, :message =>'phrase.cant_blank'

  belongs_to :grade
  
  def teachers
    Classuser.where("sclass_id=? and ltype=0",self.id).joins("LEFT OUTER JOIN users ON users.id = user_id").order("onumber,user_id")
  end
  
  def students
    Classuser.where("sclass_id=? and ltype=1",self.id).joins("LEFT OUTER JOIN users ON users.id = user_id").order("onumber,user_id")
    #Classuser.all(:include => :user, :conditions => {:sclass_id=>self.id,:ltype=>1})  
  end
  
  def add_user(user,ltype)
    user.add_role(ltype==0?"teacher":"student")
                  
    begin
      cuser=Classuser.new(:sclass_id=>self.id,:sclassname=>self.name, :user_id=>user.id, :username=>user.name,:onumber=>user.login,:ltype=>ltype)
      cuser.save!
    rescue
    
    end
  end
  
  def remove_user(user_id,ltype)
    Classuser.delete_all(["sclass_id=? and ltype=? and user_id=?",self.id,ltype,user_id])
  end
  
  def repair_users
    for cuser in Classuser.all
      user=User.find(cuser.user_id)
      unless user.nil?
        cuser.update_attributes(:username=>user.name,:onumber=>user.login)
      end
      
      sclass=Sclass.find(cuser.sclass_id)
      unless sclass.nil?
        cuser.update_attributes(:sclassname=>sclass.name)
      end
    end
  end
  
  def courses
    Courseuser.where("link_id=? and ltype=2",self.id).order("onumber")
  end
  
  def remove_course(course_id)
    Courseuser.delete_all(:course_id=>course_id,:link_id=>self.id,:ltype=>2)
  end

end
