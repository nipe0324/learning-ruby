require 'rails_helper'

RSpec.describe Api::TaskListsController, :type => :controller do
  describe "#index" do
    context "for user that has a task list" do
      let(:user)  { create(:user) }

      context "when authenticated as that user" do
        before      { sign_in(user) }

        it "is expected to return json of array of those task lists" do
          get :index
          expect(json_response).to eq [{ 'id' => user.first_list.id }]
        end
      end

      it "is expected to return error json with 401 HTTP status when not authenticated" do
        get :index, format: :json

        expect(json_response['error']).to  eq 'You need to sign in or sign up before continuing.'
        expect(response.status).to eq 401
      end

    end
  end

end
