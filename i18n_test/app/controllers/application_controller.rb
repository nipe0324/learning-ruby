class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end


  # サブドメインから取得
  # before_action :set_locale

  # def set_locale
  #   I18n.locale = extract_locale_from_tld || I18n.default_locale
  # end

  # # サブドメインからlocaleを取得する
  # # 有効なlocaleが見つからない場合は、nilを返す
  # def extract_locale_from_tld
  #   parsed_locale = request.subdomains.first
  #   I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  # end

  # パラメータから取得
  # before_action :set_locale

  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end

  # # localeを変える
  # # app/controllers/application_controller.rb
  # # link_toなどのすべてのURLにlocaleパラメータが自動でつくようになる
  # def default_url_options(options = {})
  #   { locale: I18n.locale }.merge options
  # end
end
