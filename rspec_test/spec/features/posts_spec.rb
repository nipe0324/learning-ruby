require 'rails_helper'

RSpec.describe "Posts", :type => :feature do
  describe "一覧画面" do
    before do
      @delete_post = create(:post) # 投稿を作成
      visit posts_path      # 一覧画面に遷移
    end

    it "投稿一覧画面が表示されること" do
      expect(page.current_path).to eq posts_path
    end
  end

  describe "新規登録" do
    before do
      visit posts_path      # 一覧画面に遷移
      click_link "New Post" # "New Post"リンクを押す
    end

    it "投稿新規作成画面が表示されること" do
      expect(page.current_path).to eq new_post_path
    end

    it "投稿を新規作成できること" do
      # テキストフィールドに値を入力する
      fill_in "Title",   with: "タイトル"
      fill_in "Content", with: "本文"
      click_button "Create Post"

      # 画面に"Post was ..."と表示されていることを確認
      expect(page).to have_content "Post was successfully created."
      expect(page).to have_content "タイトル"
      expect(page).to have_content "本文"

      # データベースに登録された内容を確認(必要に応じて確認)
      post = Post.last
      expect(post.title).to eq "タイトル"
      expect(post.content).to eq "本文"
    end
  end
end
