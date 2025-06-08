class ShoppingList < ApplicationRecord
  belongs_to :user

  has_many :shopping_list_items, dependent: :destroy
  has_many :items, through: :shopping_list_items
  has_one :purchased_history, dependent: :destroy

  validates :title, presence: true

  enum status: {incomplete: 0, complete: 1 }

  def self.statuses_i18n
    statuses.keys.index_with do |key|
      I18n.t("activerecord.attributes.shopping_list.status.#{key}")
    end
  end

  def status_i18n
    I18n.t("activerecord.attributes.shopping_list.status.#{status}")
  end
end
