class RemoveContentFromQuotes < ActiveRecord::Migration
  def change
    remove_column :quotes, :content, :string
    add_column :quotes, :content, :text
  end
end
