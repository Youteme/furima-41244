class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_owner, only: [:edit, :update]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    return redirect_to root_path if @item.save

    render 'new', status: :unprocessable_entity
  end

  def show
  end

  def edit
    return if @item.order.nil?

    redirect_to root_path
  end

  def update
    return redirect_to item_path(@item) if @item.update(item_params)

    render 'edit', status: :unprocessable_entity
  end

  def destroy
    return redirect_to root_path if @item.destroy

    render 'show', status: :unprocessable_entity
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :item_status_id, :shipping_cost_id, :prefecture_id,
                                 :shipping_date_id, :price).merge(user_id: current_user.id)
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def redirect_unless_owner
    return if current_user.id == @item.user_id

    redirect_to action: :index
  end
end
