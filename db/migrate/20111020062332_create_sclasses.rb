class CreateSclasses < ActiveRecord::Migration
  def change
    create_table :sclasses do |t|
      t.string :name
      t.integer :cid
      t.integer :status
      t.integer :ctype
      t.text :address
      t.text :description

      t.timestamps
    end
  end
end
