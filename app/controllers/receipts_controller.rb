class ReceiptsController < ApplicationController
  require "securerandom"

  def process_receipt
    @unique_id = SecureRandom.uuid
    receipt = Receipt.transaction do
      Receipt.create!(retailer: "Target", purchased_at: "2022-01-01-13:01", total_cents: 3535, unique_id: @unique_id)
    end
    render json: { id: receipt.unique_id }
  end

  def process_item
    Item.create!(short_description: "Mountain Dew 12pk", price_cents: 649)
    Item.create!(short_description: "Emils Cheese Pizza", price_cents: 1225)
    Item.create!(short_description: "Knorr Creamy Chicken", price_cents: 126)
    Item.create!(short_description: "Doritos Nacho Cheese", price_cents: 335)
    Item.create!(short_description: "Klarbrunn 12pk 12 fl oz", price_cents: 1200)
  end

  def points
    @points = 0
    @points += retailer.length
    @points += items.length / 2
    if total[-1].to_i == 0 && total[-2].to_i == 0
      @points += 50
    elsif total[-1].to_i == 5 && total[-2].to_i == 2
      @points += 25
    elsif total[-1].to_i == 0 && total[-2].to_i == 5
      @points += 25
    elsif total[-1].to_i == 7 && total[-2].to_i == 5
      @points += 25
      # eleminating blank space in shortDescription with .gsub(/\s+/, "")
    elsif shortDescription.gsub(/\s+/, "").length % 3
      @points += 0.2
    elsif purchaseDate[-1].to_i.odd?
      @points += 6
    elsif purchaseTime[0].to_i == 1 && purchaseTime[1].to_i > 4 && purchaseTime[1].to_i < 6
      @points += 10
    end
    return @points
  end
end
