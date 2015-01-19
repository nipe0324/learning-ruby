class NewsDeliverJob < ActiveJob::Base
  queue_as :default

  # performメソッド内でActiveRecord::RecordNotFoundが発生した場合、
  # ログに出力する
  rescue_from(ActiveRecord::RecordNotFound) do |exception|
    Rails.logger.error "Letterレコードは見つかりませんでした。"
  end

  def perform(letter_id)
    # 例外処理のハンドリングのために無理やり例外を発生させる
    raise ActiveRecord::RecordNotFound
    Letter.find(letter_id).deliver
  end
end
