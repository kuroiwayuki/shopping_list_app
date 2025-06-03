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
    if @shopping_list.save
      redirect_to new_shopping_list_path, notice: "作成完了✍️"
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
    
    data = shopping_list_params
    
    item_params = data[:shopping_list_items]
    # エラー起きてるのでチェック必要
    @item = Item.find_by(name: item_params[:item_name])
    binding.pry
    @quantity = item_params[:quantity].to_i
    @recently_purchased = PurchaseHistory.exists?(user: current_user, item: @item)

    respond_to do |format|
      format.turbo_stream
    end
  end


  private

  def shopping_list_params
    params.require(:shopping_list).permit(:title, shopping_list_items: [:id, :item_name, :item_id, :quantity, :_destroy ])

  end
end
