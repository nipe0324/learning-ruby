class User < ActiveRecord::Base
  def debug
    logger.fatal "致命的なエラー情報"
    logger.error "エラー情報"
    logger.warn  "警告情報"
    logger.info  "お知らせ情報"
    logger.debug "デバッグ情報"
  end
end
