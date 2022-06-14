class CreateScrapeErrors < ActiveRecord::Migration[6.1]
  def up
    create_table :scrape_errors do |t|
      t.string :error, null: false
      t.references :stream_service, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :scrape_errors
  end
end
