class CreateClassusers < ActiveRecord::Migration
  def change
    create_table :classusers do |t|
      t.integer :sclass_id
      t.integer :user_id
      t.string :username
      t.integer :ltype

      t.timestamps
    end
  end
end
