class AddStatusToShoppingLists < ActiveRecord::Migration[7.2]
  def change
    add_column :shopping_lists, :status, :integer, default: 0, null: false
  end
end
