class CreateSeresults < ActiveRecord::Migration
  def change
    create_table :seresults do |t|
      t.integer :student_id
      t.string :student_name
      t.integer :exam_id
      t.integer :etype
      t.text    :answer
      t.integer :score
      t.integer :status
	  
      t.timestamps
    end
  end
end
