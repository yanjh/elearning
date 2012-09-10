class CreateCexams < ActiveRecord::Migration
  def change
    create_table :cexams do |t|
      t.integer :chapter_id
      t.string  :name
      t.text    :description
      t.integer :etype
      t.integer :status
      t.integer :score
	  
      t.timestamps
    end
  end
end
