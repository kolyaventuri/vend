class Owner < ApplicationRecord
  has_many :machines

  validates_presence_of :name
end
