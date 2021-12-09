class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def find
    merchant = Merchant.find_one(params[:name])
      if merchant
        render json: MerchantSerializer.new(merchant)
      else
        render json: PlaceHolder.merchant
      end
  end

  def find_all
    render json: MerchantSerializer.new(Merchant.find_all(params[:name]))
  end
end