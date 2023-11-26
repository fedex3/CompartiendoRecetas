class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string, :limit => 100
    add_column :users, :detail, :string
    add_column :users, :is_admin, :bool
  end
end