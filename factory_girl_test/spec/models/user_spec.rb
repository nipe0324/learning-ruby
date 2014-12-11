require 'rails_helper'

RSpec.describe User, :type => :model do
  it do
    p build(:user)
    p create(:user)
    p build_stubbed(:user)
    p attributes_for(:user)
    user = create(:user) do |user|
      user.posts.create(attributes_for(:post))
    end
    p user
    p user.posts
  end
end
