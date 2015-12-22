class AddListToBook < ActiveRecord::Migration
  def change
    add_reference :books, :list, index: true, foreign_key: true
  end
end
