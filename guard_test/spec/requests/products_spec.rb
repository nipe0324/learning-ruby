require 'rails_helper'

RSpec.describe "Products", :type => :request do
  describe "GET /products" do
    it "works! (now write some real specs)" do
      get products_path
      expect(response.status).to be(200)
    end
  end
end
