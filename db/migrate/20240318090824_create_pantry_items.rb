class CreatePantryItems < ActiveRecord::Migration[7.1]
  def change
    create_table :pantry_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.float :quantity
      t.string :unit_of_measurement

      t.timestamps
    end
  end
end
