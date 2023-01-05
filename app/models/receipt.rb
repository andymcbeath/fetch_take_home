class Receipt < ApplicationRecord
  has_many :items

  before_save :calculate_total

  accepts_nested_attributes_for :items

  def points
    [
      points_from_retailer_name,
      points_from_item_count,
      points_from_total_being_round
    ].sum
    # elsif total[-1].to_i == 5 && total[-2].to_i == 2
    #   @points += 25
    # elsif total[-1].to_i == 0 && total[-2].to_i == 5
    #   @points += 25
    # elsif total[-1].to_i == 7 && total[-2].to_i == 5
    #   @points += 25
    #   # eleminating blank space in shortDescription with .gsub(/\s+/, "")
    # elsif shortDescription.gsub(/\s+/, "").length % 3
    #   @points += 0.2
    # elsif purchaseDate[-1].to_i.odd?
    #   @points += 6
    # elsif purchaseTime[0].to_i == 1 && purchaseTime[1].to_i > 4 && purchaseTime[1].to_i < 6
    #   @points += 10
    # end
    # return @points
  end

  private

  def calculate_total
    self.total_cents = items.sum(&:price_cents) 
  end

  def points_from_retailer_name
    retailer.length
  end

  def points_from_item_count
    items.count / 2
  end

  def points_from_total_being_round
    (total_cents % 100).zero? ? 50 : 0
  end
end
