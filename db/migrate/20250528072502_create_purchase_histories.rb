class CreatePurchaseHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :purchase_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.datetime :purchased_at

      t.timestamps
    end
  end
end
