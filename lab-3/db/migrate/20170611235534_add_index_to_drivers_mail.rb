class AddIndexToDriversMail < ActiveRecord::Migration[5.1]
  def change
  	add_index :drivers, :mail, unique: true
  end
end
