class ReceiptsController < ApplicationController
  require "securerandom"

  def process_receipt
    receipt = Receipt.transaction do
      Receipt.create!(
        retailer: params[:retailer], 
        purchased_at: params[:purchaseDate], 
        unique_id: SecureRandom.uuid,
        items: params[:items].map do |item|
          Item.create(
            short_description: item[:shortDescription].strip, 
            price_cents: item[:price].to_d * 100
          )
        end
      )
    end

    render json: { id: receipt.unique_id }
  end

  def points
    receipt = Receipt.find_by(unique_id: params[:id])

    render json: { points: receipt.points }
  end
end
