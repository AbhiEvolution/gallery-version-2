class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos, &:timestamps
  end
end
