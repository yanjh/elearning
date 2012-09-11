class Question < ActiveRecord::Base
  #has_many :questions, :order=>"ocpcode"
  belongs_to :cexam
  
  def problem
    Problem.find(self.problem_id)
  end
end