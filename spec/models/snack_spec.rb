require 'rails_helper'

describe Snack, type: :model do
  it { is_expected.to have_many(:snack_machines) }
  it { is_expected.to have_many(:machines).through(:snack_machines) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price) }
end