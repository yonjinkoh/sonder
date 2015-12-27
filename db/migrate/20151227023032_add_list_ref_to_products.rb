class AddListRefToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :list, index: true, foreign_key: true
  end
end
