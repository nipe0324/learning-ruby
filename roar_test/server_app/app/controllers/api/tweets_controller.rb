module Api
  class TweetsController < ApplicationController
    skip_before_action :verify_authenticity_token

    # GET /tweets
    def index
      @tweets = Tweet.all
      render json: @tweets.extend(::Json::Tweet::Representer.for_collection)
        # [
        #   {
        #     "id": 1,
        #     "content": "tweet 1",
        #     "tags": [
        #       { "id": 1000, "name": "tag 1" },
        #       { "id": 1001, "name": "tag 2" }
        #     ]
        #   },
        #   {
        #     "id": 2,
        #     "content": "tweet 2",
        #     "tags": []
        #   }
        # ]
    end

    # GET /tweets/1
    def show
      @tweet = Tweet.find(params[:id])
      render json: @tweet.extend(::Json::Tweet::Representer)
        # {
        #   "id": 1,
        #   "content": "tweet 1",
        #   "tags": [
        #     { "id": 1000, "name": "tag 1" },
        #     { "id": 1001, "name": "tag 2" }
        #   ]
        # }
    end

    # POST /tweets
    def create
      tweet = Tweet.new.extend(::Json::Tweet::Server).from_json(request.body.read)
      # from_hashも使える
      # tweet = Tweet.new.extend(::Json::Tweet::Server).from_hash(tweet_params)

      if tweet.save
        render json: tweet
      else
        render json: tweet.errors.full_messages
      end
    end

    # PATCH/PUT /tweets/1
    def update
      tweet = Tweet.find(params[:id])
      tweet.extend(::Json::Tweet::Representer).from_json(request.body.read)
      # from_hashも使える
      # tweet.extend(::Json::Tweet::Representer).from_hash(tweet_params)

      if tweet.save
        render json: tweet
      else
        render json: tweet.errors.full_messages
      end
    end

    # DELETE /tweets/1
    def destroy
      tweet = Tweet.find(params[:id])
      if tweet.destroy
        head :ok
      else
        render json: tweet
      end
    end

    private
      # Only allow a trusted parameter "white list" through.
      def tweet_params
        params.require(:tweet).permit(:content, tag_ids: [])
      end
  end
end
