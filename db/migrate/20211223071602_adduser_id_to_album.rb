# frozen_string_literal: true

class AdduserIdToAlbum < ActiveRecord::Migration[6.1]
  def change
    add_reference :albums, :user,  index:  true
  end
end
 