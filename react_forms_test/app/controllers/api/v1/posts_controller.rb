class Api::V1::PostsController < ApplicationController

  before_action :load_post, only: [:show, :update, :destroy]

  def index
    @posts = Post.order("updated_at DESC").includes(:category)
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render :show, status: :created
    else
      render_errors(@post)
    end
  end

  def update
    if @post.update(post_params)
      render :show
    else
      render_errors(@post)
    end
  end

  def destroy
    @post.destroy
    head :no_content
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end

  def post_params
    hash = params.permit(:category_id, :body, :title, tags: [:id, :name, :_destroy])
    # replace `tags` key with `tags_attributes` key
    hash[:tags_attributes] = hash[:tags]
    hash.delete(:tags)
    hash
  end
end
