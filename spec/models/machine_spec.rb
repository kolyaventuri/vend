require 'rails_helper'

describe Machine, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:owner) }
    it { is_expected.to have_many(:snacks) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:location) }
  end

  describe 'methods' do
    before(:all) do
      DatabaseCleaner.clean
    end

    after(:all) do
      DatabaseCleaner.clean
    end

    it 'can calculate average price' do
      owner = Owner.create!(name: "Sam's Snacks")
      dons = owner.machines.create!(location: "Don's Mixed Drinks")

      snacks = [
        dons.snacks.create!(name: 'Yummy Gummies', price: 200),
        dons.snacks.create!(name: 'Yucky Uckys', price: 50),
        dons.snacks.create!(name: 'Hey, not bad.', price: 300),
        dons.snacks.create!(name: 'Sub par at best.', price: 50)
      ]

      avg = snacks.reduce(0) { |s, snack| s + snack.price }
      avg /= snacks.length.to_f
      avg /= 100.0

      expect(dons.average_price).to be(avg)
    end
  end
end
