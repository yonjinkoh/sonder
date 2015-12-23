class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key "categories", "lists", name: "categories_list_id_fk"
  end
end
