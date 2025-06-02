class ShoppingListItemsController < ApplicationController
  def update
    item = ShoppingListItem.find(params[:id])

    item.update(checked: params[:shopping_list_item][:checked])
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  end
end
