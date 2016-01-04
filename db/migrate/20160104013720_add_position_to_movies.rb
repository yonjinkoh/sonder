class AddPositionToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :position, :integer
  end
end
