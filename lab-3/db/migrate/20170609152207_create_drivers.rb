class CreateDrivers < ActiveRecord::Migration[5.1]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :mail
      t.integer :phone
      t.float :balance
      t.string :licence
      t.float :fare
      t.text :ratings
      t.references :position

      t.timestamps
    end
  end
end
