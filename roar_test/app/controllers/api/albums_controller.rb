class Api::AlbumsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :json

  def index
    albums = Album.all
    respond_with albums, represent_with: AlbumRepresenter.for_collection
  end

  def show
    album = Album.find_by_id(params[:id])
    respond_with album, represent_with: AlbumRepresenter
  end

  def create
    album = Album.new
    consume!(album)
    respond_with album, represent_with: AlbumRepresenter
  end
end
