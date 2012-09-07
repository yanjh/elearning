class AddOnumberToCourseuser < ActiveRecord::Migration
  def change
    add_column :courseusers, :onumber, :string
  end
end
