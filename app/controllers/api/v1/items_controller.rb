class Api::V1::ItemsController < ApplicationController
  def index
    render json: Item.all
  end

  def show
    render json: Item.find(params[:id])
  end

  def create
    render json: Item.create(params[item_params]), status: 201
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  def merchant
    render json: Item.find(params[:id]).merchant
  end

  private

  def item_params
    params.permit(:item, :name, :description, :unit_price, :merchant_id)
  end
end