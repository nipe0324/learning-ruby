require 'rails_helper'

RSpec.describe TemplatesController, :type => :controller do
  describe "#index" do
    it "is expected to return 200 for the template" do
      get :index
      expect(response).to be_ok
    end
  end
end
