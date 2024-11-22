class CreateReservations < ActiveRecord::Migration[7.2]
  def change
    create_table :reservations do |t|
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.integer :total_people
      t.integer :total_day
      t.integer :total_amount
      t.timestamps
    end
  end
end
