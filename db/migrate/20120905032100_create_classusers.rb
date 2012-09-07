class CreateClassusers < ActiveRecord::Migration
  def change
    create_table :classusers do |t|
      t.integer :sclass_id
      t.integer :user_id
      t.string :username
      t.string :sclassname
      t.integer :ltype
      t.string :onumber

      t.timestamps
    end
 	add_index :classusers, [:sclass_id, :user_id, :ltype], :unique => true
  end
end
