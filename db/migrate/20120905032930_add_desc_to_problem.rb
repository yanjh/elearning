class AddDescToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :description, :text
  end
end
