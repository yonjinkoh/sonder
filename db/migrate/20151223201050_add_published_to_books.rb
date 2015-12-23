class AddPublishedToBooks < ActiveRecord::Migration
  def change
    add_column :books, :published, :string
  end
end
