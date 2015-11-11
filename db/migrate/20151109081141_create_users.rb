class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.text :description
      t.string :facebook
      t.string :profile_picture

      t.timestamps null: false
    end
  end
end