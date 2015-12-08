class CreateListsAndCategories < ActiveRecord::Migration
  def change
    create_table :lists_categories do |t|
      t.belongs_to :list, index: true
      t.belongs_to :part, index: true
    end
  end
end
