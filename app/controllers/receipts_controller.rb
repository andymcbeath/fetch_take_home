class ReceiptsController < ApplicationController
  def process_receipt
    receipt = Receipt.transaction do
      Receipt.create(retailer: "Target", purchased_at: "12-01-14", total_cents: 25)
      Item.create(short_description: "Mountain Dew 12pk", price_cents: 649)
    end
    render json: { id: receipt.unique_id }
  end

  def points
    return @points
  end
end
