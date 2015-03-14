class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    # profiderとuidでuserレコードを検索。存在しなければ、新たに作成する
    user = User.from_omniauth(request.env["omniauth.auth"])
    # userレコードが既に保存されているか
    if user.persisted?
      # ログインに成功
      flash.notice = "ログインしました!!"
      sign_in_and_redirect user
    else
      # ログインに失敗し、サインイン画面に遷移
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  # alias_methodはクラスやモジュールのメソッドに別名をつけます
  # 実態がallメソッドのtwitterメソッドを定義しています
  # こうすることで、様々なメソッド名で同じ処理を実装することができます。
  # OAuthの処理はほとんど同じためこのようにしています。
  # 例えば、Facebookに対応する場合、alias_method :facebook, :allだけですみます
  alias_method :twitter,  :all
  alias_method :facebook, :all
end
