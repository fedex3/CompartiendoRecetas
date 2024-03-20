class CreateJoinTableUsersTags < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :tags do |t|
      t.index [:user_id, :tag_id]
      t.index [:tag_id, :user_id]

      t.timestamps
    end
  end
end
