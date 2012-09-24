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
    crs= Mlink.where("id2=? and ltype=?",self.id, Mlink::T_COURSE_CLASS).order("order1")
    s="0"
    crs.each {|c| s+=","+c.id1.to_s }
    s=="0"?nil:Course.where(" id in("+s+")").order("ccode")
  end
  
  def add_course(course)
    Mlink.create(:id1=>course.id,:name1=>course.title,:order1=>course.ccode,:id2=>self.id,:name2=>self.name,:ltype=>Mlink::T_COURSE_CLASS)
  end
  
  def remove_course(course_id)
    Mlink.delete_all(:id1=>course_id,:id2=>self.id,:ltype=>Mlink::T_COURSE_CLASS)
  end
  
  def chapters_s
    s=""
    cps=Mlink.where(:id2=>self.id,:ltype=>Mlink::T_CHAPTER_CLASS)
    cps.each {|c| s+=","+c.id1.to_s }
    #logger.debug "-----------------------s: #{s}"
    (s.blank?)?nil:s[1..-1]
  end

  def chapters
    cps=self.chapters_s
    (cps.nil?)?nil:Chapter.where(" id in("+cps+")").order("course_id, cpcode")
  end  
end
