require 'rails_helper'

describe Machine, type: :model do
  it { is_expected.to belong_to(:owner) }
  it { is_expected.to have_many(:snacks) }

  it { is_expected.to validate_presence_of(:location) }
end