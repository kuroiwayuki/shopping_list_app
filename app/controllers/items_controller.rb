class ItemsController < ApplicationController
  def autocomplete
    items = Item.where("name ILIKE ?", "%#{params[:q]}%").limit(10)
    render json: items.select(:id, :name)
  end
end
