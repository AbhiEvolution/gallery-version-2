class PhotosController < ApplicationController
  def destroy
    @album = Album.find(params[:album_id])
    attachment = ActiveStorage::Attachment.find(params[:photo_id])
    attachment.purge # or use purge_later
    redirect_back(fallback_location: albums_url)
  end
end
