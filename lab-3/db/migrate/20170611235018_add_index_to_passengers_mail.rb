class AddIndexToPassengersMail < ActiveRecord::Migration[5.1]
  def change
  	add_index :passengers, :mail, unique: true
  end
end
