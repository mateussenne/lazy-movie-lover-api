class ChangeImageToPosterImage < ActiveRecord::Migration[6.1]
  def up
    rename_column :movies, :image, :poster_image
  end

  def down
    rename_column :movies, :poster_image, :image
  end
end
