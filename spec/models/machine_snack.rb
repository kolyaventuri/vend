require 'rails_helper'

descibe MachineSnack, type: :model do
  it { is_expected.to belong_to(:snack) }
  it { is_expected.to belong_to(:machine) }
end