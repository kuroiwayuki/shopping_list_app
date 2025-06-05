class PurchaseHistoriesController < ApplicationController
  def index
    binding.pry
        @purchase_histories = current_user.purchase_histories.all
  end

  def create
    user_shopping_list = current_user.shopping_lists.find(params[:id])

    ActiveRecord::Base.transaction do
      user_shopping_list.shopping_list_items.each do |item|
        history = current_user.purchase_histories.build(
          item_id: item.item_id,
          purchased_at: Time.current
        )

        unless history.save
          Rails.logger.error("保存失敗💩: #{history.errors.full_messages}")
          flash[:alert] = "保存失敗💩: #{history.errors.full_messages.join(', ')}"
          raise ActiveRecord::Rollback
        end
      end
    end

    redirect_to shopping_lists_path, notice: "購入完了したにょーん💩"
  end
end
