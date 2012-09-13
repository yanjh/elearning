class Sqresult < ActiveRecord::Base
  
  def self.one(sid,qid)
    Sqresult.where("student_id=? and question_id=?",sid,qid).limit(1).first
  end
  
end