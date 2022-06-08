class AddUniqueToMoviesSlugs < ActiveRecord::Migration[6.1]
  def up
    add_index :movies, :slug, unique: true
  end
end
