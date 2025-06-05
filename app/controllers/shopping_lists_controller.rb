class ShoppingListsController < ApplicationController
  before_action :require_login
  def index
    @shopping_lists = ShoppingList.includes(:user)
  end

  def new
    @shopping_list = ShoppingList.new
    @shopping_list.shopping_list_items.build
  end

  def create
    @shopping_list = current_user.shopping_lists.build(shopping_list_params)
    shopping_list_items_params = shopping_list_items_raw
    if @shopping_list.save
      # 子要素を手動で保存
      shopping_list_items_params.each do |item_data|
        
        @shopping_list.shopping_list_items.create(
          item_id: item_data[:item_id],
          quantity: item_data[:quantity]
        )
      end

      redirect_to shopping_list_path(@shopping_list), notice: "作成完了✍️"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @shopping_list = current_user.shopping_lists.find(params[:id])
  end

  def edit
    @shopping_list = current_user.shopping_lists.find(params[:id])
  end
  def update
    @shopping_list = current_user.shopping_lists.find(params[:id])
    if @shopping_list.update(shopping_list_params)
      redirect_to shopping_list_path(@shopping_list)
    else
      render edit, notice: "もう一度オネシャス🙇"
    end
  end

  def destroy
    @shopping_list = current_user.shopping_lists.find(params[:id])
    if @shopping_list.destroy
      render index, notice: "削除したにょーん✌️"
    else
      render index, notice: "失敗したにょん、、、、😭"
    end
  end

  def add_item
    data = shopping_list_items_raw
    # エラー起きてるのでチェック必要
    default_category = Category.find_or_create_by(name: "未分類")
    @item = Item.find_or_create_by(name: data[:item_name]) do |item|
     item.unit = "個" # または他のデフォルト
     item.category = default_category
    end
    @quantity = data[:quantity].to_i
    @recently_purchased = PurchaseHistory.exists?(user: current_user, item: @item)


    respond_to do |format|
      format.turbo_stream
    end
  end


  private

  def shopping_list_params
    params.require(:shopping_list).permit(:title)
  end

  # 子モデル用（permitしない。ハッシュのままで処理）
  def shopping_list_items_raw
    params[:shopping_list][:shopping_list_items]
  end
end
