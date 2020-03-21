class Api::V1::Items::FindersController < ApplicationController

  def index
    if item_params[:name] || item_params[:description]
      attribute = item_params.keys.first
      render json: ItemSerializer.new(Item.where("#{attribute} LIKE ?", "%#{item_params[attribute.to_sym]}%"))
    else
      render json: ItemSerializer.new(Item.where(item_params))
    end
  end

  def show
    if item_params[:name] || item_params[:description]
      attribute = item_params.keys.first
      render json: ItemSerializer.new(Item.find_by("#{attribute} LIKE ?", "%#{item_params[attribute.to_sym]}%"))
    else
      render json: ItemSerializer.new(Item.find_by(item_params))
    end
  end

  private
    def item_params
      params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
    end
end
