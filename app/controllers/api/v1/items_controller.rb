class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: ItemSerializer.new(Item.create(item_params)), status: 201
  end

  def update
    item = Item.find(params[:id])
    if item.update_attributes(item_params)
      render json: ItemSerializer.new(item)
    else
      render json: {error: "couldn't update item"}, status: 400
    end
  end

  def destroy
    render json: Item.delete(params[:id]), status: 204
  end

  def find
    item = Item.find_one(params[:name])

    if item
      render json: ItemSerializer.new(item)
    else
      render json: PlaceHolder.item
    end
  end

  def find_all
    render json: ItemSerializer.new(Item.find_all(params[:name]))
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end