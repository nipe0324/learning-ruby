require 'rails_helper'

RSpec.describe Post, :type => :model do
  describe "NullDBの効果" do
    it "10_000件の投稿があること" do
      10_000.times do |n|
        post = create(:post)
        expect(post.title).to eq "MyString"
      end
    end
  end

  describe "#title" do
    it { is_expected.to validate_presence_of :title }
  end
end
