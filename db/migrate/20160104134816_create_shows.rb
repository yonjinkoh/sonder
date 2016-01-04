class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.integer :position
      t.string :name
      t.string :description
      t.string :picture
      t.integer :list_id

      t.timestamps null: false
    end
  end
end
