class AddSlugToMovie < ActiveRecord::Migration[6.1]
  def up
    add_column :movies, :slug, :string
  end

  def down
    remove_column :movies, :slug
  end
end
