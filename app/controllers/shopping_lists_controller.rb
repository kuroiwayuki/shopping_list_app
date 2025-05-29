class ShoppingListsController < ApplicationController
  before_action :require_login
  def index
    @shopping_lists = ShoppingList.includes(:user)
  end

  def new
    @shopping_list = ShoppingList.new
  end

  def create
    @shopping_list = ShoppingList.find(params[:id])
  end
  def edit;end
  def update;end

  def add_item
    data = params.require(:shopping_list).permit(:title, shopping_list_items: [:item_id, :quantity])
    item_params = data[:shopping_list_items]
  
    @item = Item.find(item_params[:item_id])
    @quantity = item_params[:quantity].to_i
    @recently_purchased = PurchaseHistory.exists?(user: current_user, item: @item)
    binding.pry
  
    respond_to do |format|
      format.turbo_stream
    end
  end


  private

  def shopping_list_params
    params.require(:shopping_list).permit(
      :title,
      shopping_list_items_attributes: [:item_id, :quantity, :checked]
    )
  end
end
