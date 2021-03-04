# frozen_string_literal: true

class CreateShowTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :show_times do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end

    add_index :show_times, :start_time
  end
end
