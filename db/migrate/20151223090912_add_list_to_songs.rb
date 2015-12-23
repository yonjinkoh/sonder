class AddListToSongs < ActiveRecord::Migration
  def change
    add_reference :songs, :list, index: true, foreign_key: true
  end
end
