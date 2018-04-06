class Machine < ApplicationRecord
  belongs_to :owner
  has_many :machine_snacks
  has_many :snacks, through: :machine_snacks

  validates_presence_of :location

  def average_price
    snacks.average(:price).to_f / 100.0
  end

  def average_price_formatted
    format('%.2f', average_price)
  end
end
