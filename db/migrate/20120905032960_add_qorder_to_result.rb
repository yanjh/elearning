class AddQorderToResult < ActiveRecord::Migration
  def change
    add_column :sqresults, :qorder, :integer
  end
end
