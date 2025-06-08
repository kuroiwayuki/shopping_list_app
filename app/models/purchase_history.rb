class PurchaseHistory < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :shopping_list
end
