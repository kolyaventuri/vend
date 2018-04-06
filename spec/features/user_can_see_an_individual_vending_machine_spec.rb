require 'rails_helper'

feature 'When a user visits a vending machine show page' do
  before(:each) do
    DatabaseCleaner.clean
  end

  after(:each) do
    DatabaseCleaner.clean
  end
  scenario 'they see the location of that machine' do
    owner = Owner.create!(name: "Sam's Snacks")
    dons  = owner.machines.create!(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  scenario 'they see a list of all the snacks and their prices' do
    owner = Owner.create!(name: "Sam's Snacks")
    dons  = owner.machines.create!(location: "Don's Mixed Drinks")

    snacks = [
      dons.snacks.create!(name: 'Yummy Gummies', price: 200),
      dons.snacks.create!(name: 'Yucky Uckys', price: 50),
      dons.snacks.create!(name: 'Hey, not bad.', price: 300)
    ]

    visit machine_path(dons)

    within('.snacks') do
      snacks.each do |snack|
        expect(page).to have_content(snack.name)
      end

      all('li').each_with_index do |item, i|
        within(item) do
          expect(page).to have_content(snacks[i].name)
          expect(page).to have_content(snacks[i].price / 100.0)
        end
      end
    end
  end
end
