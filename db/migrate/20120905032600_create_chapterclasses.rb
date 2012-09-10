class CreateChapterclasses < ActiveRecord::Migration
  def change
    create_table :chapterclasses do |t|
      t.integer :chapter_id
      t.string  :chaptername
      t.integer :link_id
      t.string :linkname
      t.integer :ltype
	  t.integer :status
	  
      t.timestamps
    end
	add_index :chapterclasses, [:chapter_id, :link_id, :ltype], :unique => true
  end
end
