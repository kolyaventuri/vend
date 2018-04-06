require 'rails_helper'

feature 'When a user visits a vending machine show page' do
  before(:all) do
    DatabaseCleaner.clean
  end

  after(:all) do
    DatabaseCleaner.clean
  end
  scenario 'they see the location of that machine' do
    owner = Owner.create!(name: "Sam's Snacks")
    dons  = owner.machines.create!(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  describe 'they see' do
    before(:each) do
      DatabaseCleaner.clean
      owner = Owner.create!(name: "Sam's Snacks")
      @dons = owner.machines.create!(location: "Don's Mixed Drinks")

      @snacks = [
        @dons.snacks.create!(name: 'Yummy Gummies', price: 200),
        @dons.snacks.create!(name: 'Yucky Uckys', price: 50),
        @dons.snacks.create!(name: 'Hey, not bad.', price: 300),
        @dons.snacks.create!(name: 'Sub par at best.', price: 50)
      ]
    end

    after(:each) do
      DatabaseCleaner.clean
    end

    scenario 'a list of all the snacks and their prices' do
      visit machine_path(@dons)

      within('.snacks') do
        @snacks.each do |snack|
          expect(page).to have_content(snack.name)
        end

        all('li').each_with_index do |item, i|
          within(item) do
            expect(page).to have_content(@snacks[i].name)
            expect(page).to have_content(@snacks[i].price / 100.0)
          end
        end
      end
    end

    scenario 'the average price of all the snacks' do
      visit machine_path(@dons)
      avg = @snacks.reduce(0) { |s, snack| s += snack.price }
      avg /= @snacks.length.to_f
      avg = format('%.2f', avg / 100)
      expect(page).to have_content("Average Price: $#{avg}")
    end
  end
end
