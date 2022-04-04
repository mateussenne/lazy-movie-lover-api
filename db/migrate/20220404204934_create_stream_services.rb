class CreateStreamServices < ActiveRecord::Migration[6.1]
  def change
    create_table :stream_services do |t|
      t.string :name
      t.string :base_url

      t.timestamps
    end
  end
end
