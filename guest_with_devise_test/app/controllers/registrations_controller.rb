class RegistrationsController < Devise::RegistrationsController
  # no_user      -> ok: new, create          / NG: edit, update, cancel
  # guest        -> ok: new, create          / NG: edit, update, cancel
  # current_user -> ok: edit, update, cancel / NG: new, create
  before_action :authenticate_no_user_or_guest!, except: [:new, :create]
  skip_before_filter :require_no_authentication, only:   [:new, :create], if:     :guest_user?
  before_action      :require_no_authentication, only:   [:new, :create], unless: :guest_user?
end
