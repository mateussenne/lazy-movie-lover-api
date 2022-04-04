class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :image
      t.string :url
      t.references :stream_service, null: false, foreign_key: true
      t.string :synopsis

      t.timestamps
    end
  end
end
