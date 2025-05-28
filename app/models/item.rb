class Item < ApplicationRecord
  belongs_to :category

  has_many :shopping_list_items, dependent: :destroy
  has_many :shopping_lists, through: :shopping_list_items

  has_many :purchase_histories, dependent: :destroy
end
