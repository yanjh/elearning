class Mlink < ActiveRecord::Base

  T_COURSE_TEACHER=0
  T_COURSE_ADD=1
  T_COURSE_CLASS=2

  def items1(id2,ltype)
    Mlink.where(["id2=? and ltype=?",id2,ltype]).order("order1")
  end
  
  def items2(id1,ltype)
    Mlink.where(["id1=? and ltype=?",id1,ltype]).order("order2")
  end
  
end