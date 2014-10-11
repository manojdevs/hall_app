class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :mobile
      t.text :address
      t.date :check_in_date
      t.integer :no_of_days
      t.string :room_type

      t.timestamps
    end
  end
end
