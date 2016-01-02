class AddOverviewToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :overview, :string
  end
end
