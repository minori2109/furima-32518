class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: :edit

  def index
    @items = Item.order('created_at DESC')
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
  end

  def update
    if @item.user_id == current_user.id
      if @item.update(item_params)
        redirect_to item_path(params[:id])
      else
        render :edit
      end
    end
  end

  def destroy
    redirect_to root_path if @item.user.id == current_user.id && @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :status_id, :shipping_fee_id, :shipping_area_id, :shipping_date_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless current_user.id == @item.user_id
  end
end
