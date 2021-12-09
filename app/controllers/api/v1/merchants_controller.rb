class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def find
    render json: MerchantSerializer.new(Merchant.find_one(params[:name]))
  end

  def find_all
    render json: MerchantSerializer.new(Merchant.find_all(params[:name]))
  end
end