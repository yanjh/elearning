class AddUnumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :unumber, :string
  end
end
