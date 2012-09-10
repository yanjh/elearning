class CreateCourseusers < ActiveRecord::Migration
  def change
    create_table :courseusers do |t|
      t.integer :course_id
      t.string  :coursename
      t.integer :link_id
      t.integer :ltype
      t.string :linkname

      t.timestamps
    end
	add_index :courseusers, [:course_id, :link_id, :ltype], :unique => true
  end
end
