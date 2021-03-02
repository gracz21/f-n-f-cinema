# frozen_string_literal: true

class AddIsCinemaWorkerToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_cinema_worker, :boolean, default: false
  end
end
