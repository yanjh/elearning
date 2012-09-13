class AddFeedbackToResult < ActiveRecord::Migration
  def change
    add_column :sqresults, :feedback, :string
    add_column :seresults, :feedback, :string
  end
end
