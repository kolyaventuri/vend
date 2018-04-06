require 'rails_helper'

describe Owner, type: :model do
  it { is_expected.to have_many(:machines) }
end