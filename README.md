# Fetch Rewards
## Table of contents
* [General Info](#general-info)
* [Technologies](#technologies)
* [Code Examples](#code-examples)
* [Final Product](#final-product)

## General Info
This is a take-home project to create a receipts processing backend based on the following prompt: https://github.com/fetch-rewards/receipt-processor-challenge.

## Technologies
Project is created with:
*Ruby on Rails 7.04



## Code Examples
Below is the receipts_controller code 
```
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
    end!

    return @points
  end
end
```
## Final Product
Here is the post route being run through Insomnia on http://localhost:3000/receipts/process
[Screenshot 2022-12-19 at 12 46 10 PM](https://user-images.githubusercontent.com/107561577/208497790-d35b5c9e-8db9-4525-bbba-3df5efe4f243.png)
-Things to improve:
  1. Getting the GET request to calculate the points. I had a hard time getting the items to get factored into the receipt with a a has_many relationship. I also am not sure if my code for calculating the points is correct because I was not able to test it without getting the items to work. I would love to learn more through the apprenticeship about how to approach this problem.
