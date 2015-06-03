class Api::SingersController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :json

  def index
    singers = Singer.all
    respond_with singers, represent_with: SingerRepresenter.for_collection
  end

  def show
    singer = Singer.find_by_id(params[:id])
    respond_with singer, represent_with: SingerRepresenter
  end

  def create
    singer = Singer.new
    consume!(singer)
    respond_with singer, represent_with: SingerRepresenter
  end
end
