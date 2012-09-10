class AddCourseIdToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :course_id, :integer
    add_column :chapters, :cpcode, :string
    add_column :chapters, :description, :text
  end
end
