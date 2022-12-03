class LikesController < ApplicationController
  before_action :find_photo

  def create
    album = Album.find(params[:album_id])
    p = params[:photo_id]
    photo = p.to_i
    if already_liked?
      redirect_to home_path(album)
      flash[:notice] = "You can't like more than once"
    else
      Like.create(user_id: current_user.id, photo_id: photo)
      redirect_to home_path(album)
    end
  end

  def already_liked?
    Like.where(user_id: current_user.id, photo_id: params[:photo_id]).exists?
  end

  def destroy
   @like = Like.find(params[:like_id])
    album = Album.find(params[:album_id])
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to home_path(album)
  end

  private

  def find_photo
    @photo = ActiveStorage::Attachment.find(params[:photo_id])
  end
end
