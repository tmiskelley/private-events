class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :event_name, null: false
      t.text :description, null: false
      t.date :event_date, null: false

      t.timestamps
    end
  end
end
