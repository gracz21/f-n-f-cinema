class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :omdb_id
      t.integer :omdb_fetch_status
      t.string :omdb_fetch_error
      t.float :price
      t.string :name
      t.string :description
      t.string :release_date
      t.string :imdb_rating
      t.string :runtime

      t.timestamps
    end

    add_index :movies, :omdb_id, unique: true
  end
end
