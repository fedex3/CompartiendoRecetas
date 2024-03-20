class UnitsOfMeasurement < ActiveRecord::Migration[7.1]
  def change
    create_table :units_of_measuremeent do |t|
      t.string :name, null: false, :limit => 200
      t.text :detail, :limit => 50000
      t.timestamps
    end
  end
end
