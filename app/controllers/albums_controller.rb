# frozen_string_literal: true

class AlbumsController < ApplicationController
  before_action :authenticate_user!

  def index
    @albums = current_user.albums
  end

  def all_albums
    @albums = Album.where(published: true)
  end

  def draft_album
    @albums = current_user.albums.where(published: false)
  end

  def published_album
    @albums = current_user.albums.where(published: true)
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = Album.new
  end

  def create
    debugger
    @album = current_user.albums.new(album_params)

    if @album.save
      redirect_to @album
    else
      render :new, status: :unprocessable_entity
    end
  end

  def add_photo
    # 
     @album = Album.find(params[:album_id])
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to @album
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    redirect_to root_path
  end

  private

  def album_params
    params.require(:album).permit(:title, :description, :published, :cover_photo, :all_tags, photos: [])
  end
end
