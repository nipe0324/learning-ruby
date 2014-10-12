require 'rails_helper'

RSpec.describe TaskListsController, :type => :controller do
  context "for a logged-in user with a task list" do
    let(:task_list) { create(:task_list) }
    let(:user)      { task_list.owner    }
    before          { sign_in(user)      }

    describe "#show" do
      it "is expected to return 200 for existing task list" do
        get :show, id: task_list.id
        expect(response).to be_ok
      end

      it "is expected to return RecordNotFound when task list doesn't exist" do
        expect {
          get :show, id: 0
        }.to raise_error ActiveRecord::RecordNotFound
      end

      it "is expected to return 401 Unauthorized when task list doesn't exist" do
        other_task_list = create(:task_list)
        get :show, id: other_task_list.id
        expect(response.status).to eq 401
      end
    end

  end
end
