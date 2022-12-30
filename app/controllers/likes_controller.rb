class LikesController < ApplicationController
  before_action :find_album
  before_action :find_like, only: [:destroy]

  def create
     if user_signed_in?
      if already_liked?
        redirect_to home_path(album)
        flash[:notice] = "You can't like more than once"
      else
        @album.likes.create(user_id: current_user.id)
        flash[:notice] = "You like the #{@album.title} album of #{@album.user.name}"
        redirect_to all_albums_albums_path
      end
    else
      flash[:notice] = "You have to login to continue."
      redirect_to home_index_path
    end
  end

  def already_liked?
    Like.where(user_id: current_user.id, album_id: params[:album_id]).exists?
  end

  def find_like
    @like = @album.likes.find(params[:id])
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
      flash[:alert] = "You dislike the #{@album.title} album of #{@album.user.name}"
    end
    redirect_to all_albums_albums_path
  end

  private

  def find_album
    @album = Album.find(params[:album_id])
  end
end
