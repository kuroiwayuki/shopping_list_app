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
      redirect_to new_shopping_list_path,notice: "作成完了✍️"
    end
  end
  def edit;end
  def update;end

  def add_item
    data = shopping_list_params
  
    item_params = data[:shopping_list_items_attributes].values.first
    @item = Item.find(item_params[:item_id])
    @quantity = item_params[:quantity].to_i
    @recently_purchased = PurchaseHistory.exists?(user: current_user, item: @item)
  
    respond_to do |format|
      format.turbo_stream
    end
  end


  private

  def shopping_list_params
    params.require(:shopping_list).permit(
      :title,
      shopping_list_items_attributes: [:item_id, :quantity]
    )
  end
end



