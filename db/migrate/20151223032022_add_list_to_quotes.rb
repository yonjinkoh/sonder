class AddListToQuotes < ActiveRecord::Migration
  def change
    add_reference :quotes, :list, index: true, foreign_key: true
  end
end
