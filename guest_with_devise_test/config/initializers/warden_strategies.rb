Warden::Strategies.add(:guest_user) do
  def valid?
    session[:guest_user_id].present?
  end

  def authenticate!
    guest = User.find_by(id: session[:guest_user_id])
    success!(guest) if guest.present?
  end
end
