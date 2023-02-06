class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id])
  end

  def new
  end

  def create
    if @order = Order.create(order_params)
      Address.create(address_params)
      redirect_to root_path
    else
      render "/items/#{@order.item.id}/orders"
    end
  end

  private
  def order_params
    params.permit.merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def address_params
    params.permit(:zip_code, :prefecture_id, :city, :street, :building, :phone).merge(order_id: @order.id)
  end
end
