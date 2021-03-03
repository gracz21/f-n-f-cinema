# frozen_string_literal: true

class CreateMovieRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_ratings do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :rating

      t.timestamps
    end

    add_index :movie_ratings, %i[movie_id user_id], unique: true
  end
end
