class CreateTags < ActiveRecord::Migration[7.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false, :limit => 200
      t.string :detail, :limit => 20000
    end
  end
end
