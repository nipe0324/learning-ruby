class ArticlesController < ApplicationController
  # GET /articles
  def index
    @articles = Article.all
    @tweets = ::Json::Tweet::Client.build_collection.all
  end

  # GET /articles/1
  def show
    @article = Article.find(params[:id])
    @tweet = ::Json::Tweet::Client.build.show(@article.tweet_id)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    # ::Json::Tweet.new(@article.attributes)
    #                       .extend(::Json::Tweet::Representer).extend(::Json::Tweet::Client)
    #                       .post(uri: "http://localhost:3001/tweets/", as: 'application/json')

    @tweet = ::Json::Tweet::Client.build.post
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /articles/1
  def update
    @article = Article.find(params[:id])
    # @tweet = ::Json::Tweet.new(@article.attributes)
    #                       .extend(::Json::Tweet::Representer).extend(::Json::Tweet::Client)
    #                       .put(uri: "http://localhost:3001/tweets/1", as: 'application/json')

    @tweet = ::Json::Tweet::Client.build.put(@article.tweet_id)
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article = Article.find(params[:id])

    # @tweet = ::Json::Tweet.new
    #                       .extend(::Json::Tweet::Representer).extend(::Json::Tweet::Client)
    #                       .delete(uri: "http://localhost:3001/tweets/1", as: 'application/json')

    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title, :content)
    end
end
