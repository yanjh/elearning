class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.integer :ctype
      t.string :title
      t.text :description
      t.text :content
      t.integer :state
      t.datetime :start_at
      t.datetime :end_at
	  t.integer :status
	  t.string :ccode

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
