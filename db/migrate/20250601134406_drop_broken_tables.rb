class DropBrokenTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :shopping_list_items, if_exists: true
    drop_table :shopping_lists, if_exists: true
  end
end
