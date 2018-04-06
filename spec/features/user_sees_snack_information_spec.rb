require 'rails_helper'

feature 'When a user vitis a page for a specific snack' do
  before(:all) do
    DatabaseCleaner.clean
    owner = Owner.create!(name: "Sam's Snacks")
    @dons = owner.machines.create!(location: "Don's Mixed Drinks")
    @dons2 = owner.machines.create!(location: "Don's Stuff")

    @snacks = [
      Snack.create!(name: 'Yummy Gummies', price: 200),
      Snack.create!(name: 'Yucky Uckys', price: 50),
      Snack.create!(name: 'Hey, not bad.', price: 300),
      Snack.create!(name: 'Sub par at best.', price: 50)
    ]

    @dons.snacks << @snacks[0]
    @dons.snacks << @snacks[2]

    @dons2.snacks << @snacks[0]
    @dons2.snacks << @snacks[1]
    @dons2.snacks << @snacks[2]
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  scenario 'they should see that snacks information' do
    visit snack_page(@snacks[0])

    expect(page).to have_content(@snacks[0].name)
    expect(page).to have_content(@snacks[0].price / 100.0)

    within('.locations') do
      expect(page).to have_content("#{@dons.location} (#{@dons.snacks.length} kinds of snacks, average price of #{@dons.average_price_formatted})")
      expect(page).to have_content("#{@dons2.location} (#{@dons2.snacks.length} kinds of snacks, average price of #{@dons2.average_price_formatted})")
    end
  end
end