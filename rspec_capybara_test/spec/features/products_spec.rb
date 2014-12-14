require 'rails_helper'

feature "Products", :type => :feature do
  describe "新規登録" do
    before do
      create(:product)
      visit products_path      # 一覧画面に遷移
    end

    it "削除する", js: true do
      click_link "Destroy"


      expect {
        page.driver.browser.accept_js_confirms
      }.to change { Product.count }.by(-1)
    end
  end
end
