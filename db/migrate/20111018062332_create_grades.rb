class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :name
      t.integer :gyear
      t.integer :status
      t.text :description

      t.timestamps
    end
  end
end
