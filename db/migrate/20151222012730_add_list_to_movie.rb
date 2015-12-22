class AddListToMovie < ActiveRecord::Migration
  def change
    add_reference :movies, :list, index: true, foreign_key: true
  end
end
