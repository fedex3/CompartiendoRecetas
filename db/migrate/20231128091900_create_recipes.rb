class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :name, null: false, :limit => 200
      t.text :detail, :limit => 50000
      t.float :cooking_time
      t.string :cooking_time_unit

      t.references :user, index: true, foreign_key: true
      
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
