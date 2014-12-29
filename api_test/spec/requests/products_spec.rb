require 'rails_helper'

RSpec.describe "Products", :type => :request do

  describe "GET /products.json" do
    before { @products = FactoryGirl.create_list(:product, 2) }

    it "一覧情報を取得できること" do
      # GET /products.json にアクセスする
      get products_path format: :json

      # ステータスコードの確認
      expect(response.status).to eq 200

      # JSONの確認
      json = JSON.parse(response.body)
      expect(json.size).to     eq @products.count
      expect(json[0]["id"]).to eq @products[0].id
      expect(json[1]["id"]).to eq @products[1].id

      # 詳細の値は省略
    end
  end

  describe "GET /product/:id.json" do
    before { @product = FactoryGirl.create(:product) }

    it "詳細情報を取得できること" do
      # GET /product/:id.json にアクセスする
      get product_path(@product.id, format: :json)

      # ステータスコードの確認
      expect(response.status).to eq 200

      # JSONの確認
      json = JSON.parse(response.body)
      expect(json["id"]).to    eq @product.id
      expect(json["name"]).to  eq @product.name
      expect(json["price"]).to eq @product.price
      # ... その他のカラム
    end
  end

  describe "POST /products.json" do
    it "商品情報が作成されること" do
      params = { product: FactoryGirl.attributes_for(:product) }
      # => {:product=>{:name=>"MyString", :price=>1, :publised_at=>"2014-12-29 23:40:30", :category_id=>1}}

      # 商品数が1増えることを確認
      expect {
        # POST /products.json にアクセスする
        post products_path(format: :json), params
      }.to change { Product.count }.by(1)

      # ステータスコードの確認
      expect(response.status).to eq 201

      # JSONの各値の確認
      json = JSON.parse(response.body)
      expect(json["name"]).to  eq "MyString"
      expect(json["price"]).to eq 1
      # ... その他のカラム

      # locationが作成したProductの詳細画面のURLであることを確認
      expect(response.location).to eq product_url(Product.last)
    end

    it "商品情報が作成されないこと" do
      # バリデーションエラーなどで作成されないようにし、帰り値を確認する
    end
  end

  describe "DELETE /products/:id.json" do
    before { @product = FactoryGirl.create(:product) }

    it "商品情報が削除されること" do
      # Productの数が-1されること
      expect {
        # DELETE /products/:id.json にアクセスする
        delete product_path(@product.id, format: :json)
      }.to change { Product.count }.by(-1)

      # ステータスコードの確認
      expect(response.status).to eq 204
    end
  end
end
