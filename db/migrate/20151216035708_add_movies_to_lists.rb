class AddMoviesToLists < ActiveRecord::Migration
  def change
    add_column :lists, :movie_number, :string
  end
end
