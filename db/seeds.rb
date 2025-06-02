user = User.find_by(email: "yuki8050@icloud.com")

if user
  # 必要なカテゴリを先に作成（または検索）
  vegetables = Category.find_or_create_by!(name: "野菜")

  # アイテムをカテゴリと一緒に作成
  item1 = Item.find_or_create_by!(name: "にんじん", category: vegetables)
  item2 = Item.find_or_create_by!(name: "たまねぎ", category: vegetables)

  # ショッピングリストを作成
  shopping_list = user.shopping_lists.create!(
    title: "テスト買い物リスト",
    shopping_list_items_attributes: [
      { item: item1, quantity: 2 },
      { item: item2, quantity: 1 }
    ]
  )

  puts "ShoppingList『#{shopping_list.title}』を作成しました"
else
  puts "Userが見つかりません"
end
