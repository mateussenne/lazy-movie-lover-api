class AddCodeToStreamService < ActiveRecord::Migration[6.1]
  def up
    add_column :stream_services, :code, :string
  end

  def down
    remove_column :stream_services, :code
  end
end
