class Mlink < ActiveRecord::Base

  T_COURSE_TEACHER=0
  T_COURSE_AID=1
  T_COURSE_CLASS=2

  T_CHAPTER_USER=10
  T_EXAM_USER=11

  def items1(id2,ltype)
    Mlink.where(["id2=? and ltype=?",id2,ltype]).order("order1")
  end
  
  def items2(id1,ltype)
    Mlink.where(["id1=? and ltype=?",id1,ltype]).order("order2")
  end
  
  def self.one(id1,id2,ltype)
    Mlink.where(["id1=? and id2=? and ltype=?",id1,id2,ltype]).limit(1).first
  end
  
end