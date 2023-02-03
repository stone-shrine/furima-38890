class ItemsController < ApplicationController
  before_action :move_to_sign_in, only: [:new, :edit]


  def index
    @items = Item.all.order('created_at DESC')
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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    redirect_to root_path unless current_user.id == @item.user.id
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to item_path(item)
    end
  end


  private
  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status_id, :payment_id, :prefecture_id,
                                 :lead_time_id, :price).merge(user_id: current_user.id)
  end

  def move_to_sign_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
