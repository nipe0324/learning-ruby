require 'rails_helper'

RSpec.describe TemplatesController, :type => :controller do
  describe "#index" do

    context "when logged in" do
      before { sign_in(create(:user)) }

      it "is expected to return 200 for the index" do
        get :index
        expect(response).to be_ok
      end

      it "is expected to return 200 for the template" do
        get :template, path: 'task_list.html'
        expect(response).to be_ok
      end
    end

    context "when not logged in" do
      it "is expected to redirect to sign up for the index" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end

      it "is expected to redirect to sign up for the template" do
        get :template, path: 'task_list.html'
        expect(response).to redirect_to new_user_session_path
      end
    end

  end
end
