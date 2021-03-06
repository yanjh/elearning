class Question < ActiveRecord::Base
  #has_many :questions, :order=>"ocpcode"
  belongs_to :cexam
  
  def problem
    Problem.find(self.problem_id)
  end
  
  def answer(user_id)
    sq=Sqresult.one(user_id,self.id)
    (sq.nil?)?"":sq.answer
  end
  
  def self.answers(user_id)
    Sqresult.where("student_id=?",user_id).order("qorder")
  end
end