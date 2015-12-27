class AddPinterestToUser < ActiveRecord::Migration
  def change
    add_column :users, :pinterest, :string
  end
end
