require 'rails_helper'

RSpec.describe Api::TasksController, :type => :controller do

  context "for a new logged-in user" do
    let(:user)      { create(:user) }
    before          { sign_in(user) }

    describe "#index" do
      context "for user that has a task list with some tasks" do
        let(:task_list) { create(:task_list, :with_tasks) }
        let(:task1)     { task_list.tasks[0] }
        let(:task2)     { task_list.tasks[1] }

        it "is expected to return json of array of those tasks" do
          get :index, task_list_id: task_list.id
          tasks = JSON.parse(response.body)

          expect(tasks).to eq [
            { 'id' => task1.id, 'description' => task1.description,
              'priority' => nil, 'due_date' => nil, 'completed' => false },
            { 'id' => task2.id, 'description' => task2.description,
              'priority' => nil, 'due_date' => nil, 'completed' => false }
          ]
        end
      end
    end

    describe "#create" do
      let(:post_create) do
        post :create, task_list_id: user.task_list.id, description: "New Task"
      end

      it "is expected to add the record to the database" do
        expect {
          post_create
        }.to change(Task, :count).by(1)
      end

      it "is expected to return 200 OK" do
        post_create
        expect(response).to be_success
      end
    end

  end
end
