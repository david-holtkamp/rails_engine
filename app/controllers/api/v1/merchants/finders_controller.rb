class Api::V1::Merchants::FindersController < ApplicationController

  def index
    if merchant_params[:name]
      attribute = merchant_params.keys.first
      render json: MerchantSerializer.new(Merchant.where("#{attribute} LIKE ?", "%#{merchant_params[attribute.to_sym]}%"))
    else
      render json: MerchantSerializer.new(Merchant.where(merchant_params))
    end
  end

  def show
    if merchant_params[:name]
      attribute = merchant_params.keys.first
      render json: MerchantSerializer.new(Merchant.find_by("#{attribute} LIKE ?", "%#{merchant_params[attribute.to_sym]}%"))
    else
      render json: MerchantSerializer.new(Merchant.find_by(merchant_params))
    end
  end

  private

    def merchant_params
      params.permit(:id, :name)
    end
end
