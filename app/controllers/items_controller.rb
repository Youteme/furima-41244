class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :find_item, only: [:edit, :update, :destroy]
  before_action :redirect_unless_owner, only: [:edit, :update, :destroy]

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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
  
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render 'edit', status: :unprocessable_entity
    end
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
      unless @item.user == current_user
        redirect_to root_path
      end
    end

end
