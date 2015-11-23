class TopController < ApplicationController
  def index
    @messages = Message.all
    # ビューを通さずにコントローラーからReactコンポーネントをレンダー
    # render component: 'MessageBox', props: { url: '/messages', messages: @messages }
  end
end
