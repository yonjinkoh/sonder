class AddPositionToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :position, :integer
  end
end
