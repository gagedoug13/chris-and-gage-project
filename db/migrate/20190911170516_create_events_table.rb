class CreateEventsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :event_type 
      t.string :day
      t.string :description
      t.string :time_of_day
      t.string :location
    end
  end
end
