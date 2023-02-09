class ItemsController < ApplicationController
  before_action :move_to_sign_in, only: [:new, :edit]
  before_action :find_item, except: [:index, :new, :create]

  def index
    @items = Item.all.order('created_at DESC').includes(:order)
  end

  def new
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
  end

  def edit
    redirect_to root_path if current_user.id != @item.user.id || @item.order
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy if user_signed_in? && current_user.id == @item.user.id
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status_id, :payment_id, :prefecture_id,
                                 :lead_time_id, :price).merge(user_id: current_user.id)
  end

  def move_to_sign_in
    return if user_signed_in?

    redirect_to new_user_session_path
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
