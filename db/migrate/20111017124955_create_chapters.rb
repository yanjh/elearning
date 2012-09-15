class CreateChapters < ActiveRecord::Migration
  def self.up
    create_table :chapters do |t|
      t.integer :corder
      t.string :cpcode
      t.string :title
      t.text :content
      t.text :description
      t.integer :status
	  t.integer :cid
	  t.integer :course_id
	  
      t.timestamps
    end
  end

  def self.down
    drop_table :chapters
  end
end
