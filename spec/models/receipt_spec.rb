require 'rails_helper'

RSpec.describe Receipt, type: :model do
  subject(:receipt) { described_class.create!(**receipt_params) }

  let(:receipt_params) do 
    {
      retailer: 'Target',
      purchased_at: '2022-01-01 00:00:00',
      unique_id: SecureRandom.uuid,
      items: items
    }
  end

  describe '#points' do
    let(:items) do
      [
        Item.new(
          short_description: 'Mountain Dew 12PK',
          price_cents: 649
        ),
        Item.new(
          short_description: 'Mountain Dew 12PK',
          price_cents: 649
        ),
        Item.new(
          short_description: 'Mountain Dew 12PK',
          price_cents: 649
        ),
        Item.new(
          short_description: 'Mountain Dew 12PK',
          price_cents: 649
        ),
        Item.new(
          short_description: 'Mountain Dew 12PK',
          price_cents: 649
        )
      ]
    end

    it 'adds up the points based on various criteria and returns the result' do
      expect(receipt.points).to eq(8)
    end
  end
end
