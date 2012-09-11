class CreateSqresults < ActiveRecord::Migration
  def change
    create_table :sqresults do |t|
      t.integer :student_id
      t.string :student_name
      t.integer :question_id
      t.integer :ptype
      t.string  :answer
      t.integer :score
      t.integer :status
	  
      t.timestamps
    end
  end
end
