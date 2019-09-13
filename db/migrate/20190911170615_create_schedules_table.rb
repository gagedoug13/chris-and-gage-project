class CreateSchedulesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.references :guest, foreign_key: true
      t.references :event, foreign_key: true
    end
  end
end
