class ArticlesController < ApplicationController
  # GET /articles
  def index
    @articles = Article.all
    @tweets = ::Json::Tweet::Client.build_collection.all
  end

  # GET /articles/1
  def show
    @article = Article.find(params[:id])
    @tweet = ::Json::Tweet::Client.build.show(@article.remote_tweet_id)
  end

  # GET /articles/new
  def new
    @article = Article.new
    @tags = ::Json::Tag::Client.build_collection.all
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
    @tweet = ::Json::Tweet::Client.build.show(@article.remote_tweet_id)
    @tags = ::Json::Tag::Client.build_collection.all
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    @tweet = ::Json::Tweet::Client.build.from_hash(params[:article])
    @tweet.create
    @article.remote_tweet_id = @tweet.remote_tweet_id

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  def update
    @article = Article.find(params[:id])

    @tweet = ::Json::Tweet::Client.build.from_hash(params[:article])
    @tweet.update(@article.remote_tweet_id)

    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article = Article.find(params[:id])

    @tweet = ::Json::Tweet::Client.build
    @tweet.destroy(@article.remote_tweet_id)

    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title, :content, tags: [])
    end
end
