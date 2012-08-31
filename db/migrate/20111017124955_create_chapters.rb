class CreateChapters < ActiveRecord::Migration
  def self.up
    create_table :chapters do |t|
      t.integer :corder
      t.string :title
      t.text :content
      t.integer :status
	  t.integer :cid

      t.timestamps
    end
  end

  def self.down
    drop_table :chapters
  end
end
