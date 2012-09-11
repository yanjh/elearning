class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :cexam_id
      t.integer :problem_id
      t.integer :score
      t.integer :pcode
      t.integer :qorder
      t.string  :title
      t.integer :ptype
      t.integer :status
	  
      t.timestamps
    end
  end
end
