class CreateShoppingListItems < ActiveRecord::Migration[7.2]
  def change
    create_table :shopping_list_items do |t|
      t.references :shopping_list, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity
      t.boolean :checked
      t.string :note

      t.timestamps
    end
  end
end
