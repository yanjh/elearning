class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.integer :owner
      t.string  :pcode
      t.string  :title
      t.text    :content
      t.string  :answer
      t.string  :tags
      t.integer :ptype
      t.integer :ctype
      t.integer :status
      t.integer :level
	  
      t.timestamps
    end
  end
end