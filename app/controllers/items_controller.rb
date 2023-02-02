class ItemsController < ApplicationController

  def index
  end

  def new
    unless user_signed_in?
      redirect_to new_user_session_path
    end
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end


  private
  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status, :payment, :prefecture, :lead_time, :price).merge(user_id: current_user.id)
  end
end