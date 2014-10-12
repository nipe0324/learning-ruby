require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
  let(:user) { create(:user) }

  describe "#index" do
    it "is expected to render when user is not singed in " do
      get :index

      expect(response).to be_ok
      expect(response).to render_template("index")
    end

    it "is expected to redirect to the user's task lists if singed in" do
      sign_in(user)
      get :index

      expect(response).to redirect_to(task_lists_path)
    end
  end

end
