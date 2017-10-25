class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
    	t.references :origin
    	t.references :destination
    	t.references :driver
      t.timestamps
    end
  end
end
