class User < ApplicationRecord
  has_secure_password

  has_many :shopping_lists, dependent: :destroy
  has_many :purchase_histories, dependent: :destroy
end