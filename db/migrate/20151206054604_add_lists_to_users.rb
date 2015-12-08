class AddListsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :list_id, :integer
    add_column :categories, :list_id, :integer
  end
end
