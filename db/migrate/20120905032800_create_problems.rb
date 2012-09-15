class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string  :pcode
      t.integer :owner
      t.string  :ownername
      t.text    :title
      t.text    :content
      t.text    :description
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