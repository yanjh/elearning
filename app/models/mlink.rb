class Mlink < ActiveRecord::Base

  T_CLASS_TEACHER  = 0
  T_CLASS_AID      = 1
  T_CLASS_STUDENT  = 2

  T_COURSE_TEACHER = 4
  T_COURSE_AID     = 5
  T_COURSE_CLASS   = 6

  T_CHAPTER_CLASS  = 9
  T_CHAPTER_USER   = 10
  T_CEXAM_USER     = 11

  def items1(id2,ltype)
    Mlink.where(["id2=? and ltype=?",id2,ltype]).order("order1")
  end
  
  def items2(id1,ltype)
    Mlink.where(["id1=? and ltype=?",id1,ltype]).order("order2")
  end
  
  def self.one(id1,id2,ltype)
    Mlink.where(["id1=? and id2=? and ltype=?",id1,id2,ltype]).limit(1).first
  end
  
  def t_chapter_user?
    self.ltype==Mlink::T_CHAPTER_USER
  end

  def t_cexam_user?
    self.ltype==Mlink::T_CEXAM_USER
  end
  
  def t_course_teacher?
    self.ltype==Mlink::T_COURSE_TEACHER
  end
  
  def t_course_aid?
    self.ltype==Mlink::T_COURSE_AID
  end
  
end