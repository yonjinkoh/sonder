class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :type
      t.string :description
      t.integer :position
      t.integer :list_id
      t.string :picture

      t.timestamps null: false
    end
  end
end
