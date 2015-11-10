class CreateAmazons < ActiveRecord::Migration
  def change
    create_table :amazons do |t|
      
      t.timestamps null: false
    end
  end
end
