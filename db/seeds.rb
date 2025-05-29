require 'faker'

user = User.first
raise "⚠️ Userが存在しません。先に1人作成してください。" unless user

puts "==== 🛒 テストデータ生成開始 ===="

# --- カテゴリ作成 ---
category_names = %w[果物 野菜 肉 魚 飲料 日用品]
categories = category_names.map { |name| Category.find_or_create_by!(name: name) }

# --- アイテム作成（カテゴリごとに5件ずつ） ---
items = []
categories.each do |category|
  5.times do
    item = Item.find_or_create_by!(
      name: Faker::Food.unique.ingredient,
      unit: ["個", "本", "袋", "g", "ml"].sample,
      category: category
    )
    items << item
  end
end

# --- 買い物リスト作成（10件） ---
10.times do |i|
  list = ShoppingList.create!(
    title: "リスト#{i + 1}：#{Faker::Lorem.word}",
    user: user,
    created_at: Faker::Date.backward(days: 30)
  )

  # 各リストに3〜5個のアイテムを追加
  rand(3..5).times do
    item = items.sample

    ShoppingListItem.create!(
      shopping_list: list,
      item: item,
      quantity: rand(1..5),
      checked: [true, false].sample
    )

    # 購入履歴も一部生成（50%の確率）
    if [true, false].sample
      PurchaseHistory.create!(
        user: user,
        item: item,
        purchased_at: Faker::Date.backward(days: 30)
      )
    end
  end
end

puts "✅ データ作成完了！"
