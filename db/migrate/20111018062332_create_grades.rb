class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :name
      t.integer :gyear
      t.integer :status
      t.integer :stype
      t.text :address
      t.string :geocode
      t.text :description

      t.timestamps
    end
  end
end
