class ShoppingList < ApplicationRecord
  belongs_to :user

  has_many :shopping_list_items, dependent: :destroy
  has_many :items, through: :shopping_list_items
  accepts_nested_attributes_for :shopping_list_items

  validates :title,presence: true
end
