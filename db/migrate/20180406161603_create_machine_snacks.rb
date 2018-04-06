class CreateMachineSnacks < ActiveRecord::Migration[5.1]
  def change
    create_table :machine_snacks, id: false do |t|
      t.references :machine, foreign_key: true
      t.references :snack, foreign_key: true
    end
  end
end
