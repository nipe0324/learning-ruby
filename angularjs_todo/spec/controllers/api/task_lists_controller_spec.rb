require 'rails_helper'

RSpec.describe Api::TaskListsController, :type => :controller do
  context "for user that has a task list" do
    let(:user)  { create(:user) }
    let!(:first_list)   { user.first_list      }
    let!(:second_list)  { user.task_lists.last }
    let(:other_list)    { create(:task_list)   }

    before do
      create(:task_list, owner: user)
    end

    describe "#index" do
      context "when authenticated as that user" do
        before      { sign_in(user) }

        it "is expected to return json of array with taht task list" do
          get :index

          expect(json_response).to eq [
            {"id" => second_list.id, "name" => second_list.name, "tasks" => []},
            {"id" => 2, "name" => first_list.name, "tasks" => []} ]
        end
      end

      context "when not authenticated as that user" do
        it "is expected to return error json with 401 HTTP status when not authenticated" do
          get :index, format: :json

          expect(response.status).to eq 401
          expect(json_response['error']).to  eq 'You need to sign in or sign up before continuing.'
        end
      end
    end

    describe "#create" do
      let(:post_create) do
        post :create, list: { name: "My new list" }, format: :json
      end

      context "when authenticated as that user" do
        before { sign_in(user) }

        it "is expected to add the record to the dataase" do
          expect {
            post_create
          }.to change(TaskList, :count).by(1)
        end

        it "is expected to return 200 OK" do
          post_create
          expect(response).to be_success
        end

        it "is expected to return json of the just created record" do
          post_create
          expect(json_response["id"]).to   be_an(Integer)
          expect(json_response["name"]).to eq "My new list"
        end

        it "is expected raise ParameterMission exception when task param is misssing" do
          expect {
            post :create
          }.to raise_error ActionController::ParameterMissing
        end

        it "is expected to ignore unknown paramters" do
          post :create, list: { name: "New List", foobar: 1234 }
          expect(response).to be_ok
        end
      end

      context "when not authenticated as that user" do
        it "is expected to return HTTP 401 Unauthrorized when typing to create a list" do
          post_create
          expect(response.status).to eq 401
          expect(json_response['error']).to  eq 'You need to sign in or sign up before continuing.'
        end
      end
    end

    describe "#show" do
      context "when authenticated as that user" do
        before { sign_in(user) }

        it "should return json with that task list" do
          get :show, id: first_list.id
          expect(json_response).to eq "id" => first_list.id, "name" => first_list.name, "tasks" => first_list.tasks
        end

        it "should raise RecordNotFound when trying to get a non-existent list" do
          expect {
            get :show, id: 0
          }.to raise_error ActiveRecord::RecordNotFound
        end

        it "should return HTTP 401 Unauthorized when trying to get a list of a another user" do
          get :show, id: other_list.id
          expect(response.status).to eq 401
          expect(json_response).to eq 'error' => 'unauthorized'
        end
      end

      context "when not authenticated as that user" do
        it "should return error json with 401 HTTP status" do
          get :show, id: first_list.id, format: :json
          expect(response.status).to eq 401
          expect(json_response).to eq 'error' => 'You need to sign in or sign up before continuing.'
        end
      end
    end

    describe "#destroy" do
      let(:delete_destroy) do
        delete :destroy, id: second_list.id
       end

      context "when authenticated as that user" do
        before { sign_in(user) }

        it "should remove a list from the database" do
          delete_destroy
          expect {
            second_list.reload
            }.to raise_error ActiveRecord::RecordNotFound
        end

        it "should return 200 OK" do
          delete_destroy
          expect(response).to be_success
        end

        it "should raise RecordNotFound when trying to destroy non-existent task" do
          expect {
            delete :destroy, id: 0
          }.to raise_error ActiveRecord::RecordNotFound
        end

        it "should return HTTP 401 Unauthorized when trying to delete task of another user" do
          delete :destroy, id:  other_list.id
          expect(response.status).to eq 401
          expect(json_response).to eq 'error' => 'unauthorized'
        end
      end

      context "when not authenticated as that user" do
        it "should return error json with 401 HTTP status" do
          delete :destroy, id: second_list.id, format: :json
          expect(response.status).to eq 401
          expect(json_response).to eq 'error' => 'You need to sign in or sign up before continuing.'
        end
      end
    end

  end
end
