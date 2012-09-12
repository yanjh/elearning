class CreateMlinks < ActiveRecord::Migration
  def change
    create_table :mlinks do |t|
      t.integer :id1
      t.string :name1
      t.string :order1
      t.integer :id2
      t.string :name2
      t.string :order2
      t.integer :ltype
      t.integer :status
	  
      t.timestamps
    end
    add_index :mlinks, [:id1, :id2, :ltype], :unique => true

  end
end
