class ItemsController < ApplicationController
  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    redirect_to new_user_session_path unless user_signed_in?
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

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status_id, :payment_id, :prefecture_id,
                                 :lead_time_id, :price).merge(user_id: current_user.id)
  end
end
