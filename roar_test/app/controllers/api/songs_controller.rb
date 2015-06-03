class Api::SongsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :json

  def index
    songs = Song.all
    respond_with songs, represent_with: SongRepresenter.for_collection
  end

  def show
    song = Song.find_by_id(params[:id])
    respond_with song, represent_with: SongRepresenter
  end

  def create
    binding.pry
    song = Song.create(params[:song])
    respond_with song, represent_with: SongRepresenter
  end
end
