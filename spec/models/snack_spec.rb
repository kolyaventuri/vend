require 'rails_helper'

describe Snack, type: :model do
  it { is_expected.to have_many(:machine_snacks) }
  it { is_expected.to have_many(:machines).through(:machine_snacks) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price) }
end