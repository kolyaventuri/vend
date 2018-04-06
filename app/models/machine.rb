class Machine < ApplicationRecord
  belongs_to :owner

  validates_presence_of :location
end
