require 'rails_helper'

RSpec.describe Api::TasksController, :type => :controller do
  context "for a logged-in user with two tasks" do
    let(:user) { create(:user) }
    let(:task_list) { user.task_lists.first }
    let(:task1) { task_list.tasks[0] }
    let(:task2) { task_list.tasks[1] }

    before do
      2.times { create(:task, list: task_list) }
      sign_in(user)
    end

    describe "#index" do
      it "is expected to return json of those tasks" do
        get :index, task_list_id: task_list.id
        expect(json_response).to eq [
          {'id' => task1.id, 'description' => task1.description,
            'priority' => 1, 'due_date' => nil, 'completed' => false},
          {'id' => task2.id, 'description' => task2.description,
            'priority' => 2, 'due_date' => nil, 'completed' => false}
        ]
      end

      it "is expected to raise RecordNotFound when trying to get tasks for non-existent list" do
        expect {
          get :index, task_list_id: 0
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "is expected to return HTTP 401 Unauthorized when trying to get tasks for list of another user" do
        other_task_list = create(:task_list)
        get :index, task_list_id: other_task_list.id
        expect(response.status).to eq 401
        expect(json_response['error']).to eq 'unauthorized'
      end
    end

    describe "#create" do
      let(:post_create) do
        post :create, task_list_id: task_list.id, task: {description: "New task"}
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

      it "is expected to return json of the just created record" do
        post_create
        expect(json_response["id"]).to          eq 3
        expect(json_response["completed"]).to   eq false
        expect(json_response["description"]).to eq "New task"
        expect(json_response["due_date"]).to    eq nil
      end

      it "is expected to put the new task on top of the list" do
        t1, t2 = task1, task2
        post_create

        expect(json_response['priority']).to eq 1
        expect(t1.reload.priority).to     eq 2
        expect(t2.reload.priority).to     eq 3
      end

      it "is expected to preserve passed parameters" do
        post_create
        expect(Task.order(:id).last.description).to eq "New task"
      end

      it "is expected to raise ParameterMissing exception when task param is missing" do
        expect {
          post :create, task_list_id: task_list.id
        }.to raise_error(ActionController::ParameterMissing)
      end

      it "is expected to ignore unknown parameters" do
        post :create, task_list_id: task_list.id,
          task: {description: "New task", foobar: 1234}
        expect(response).to be_ok
      end

      it "is expected to raise a validation error when description is too long" do
        expect {
          post :create, task_list_id: task_list.id, task: {description: "a"*300}
        }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "is expected to return HTTP 401 Unauthorized when trying to create task in a list of another user" do
        other_task_list = create(:task_list)
        post :create, task_list_id: other_task_list.id, task: {description: "Not mine"}

        expect(response.status).to        eq 401
        expect(json_response["error"]).to eq 'unauthorized'
      end
    end

    describe "#update" do
      let(:patch_update) do
        patch :update, task_list_id: task_list.id, id: task1.id,
          task: {description: "New description", target_priority: 2, completed: true}
      end

      it "is expected to update passed parameters of the given task" do
        patch_update
        expect(task1.reload.description).to eq "New description"
        expect(task1.priority).to  eq 2
        expect(task1.completed).to eq true
      end

      it "is expected to return 200 OK" do
        patch_update
        expect(response).to be_success
      end

      it "is expected to raise RecordNotFound when trying to update non-existent task" do
        expect {
          patch :update, task_list_id: task_list.id, id: 0,
            task: {description: "New description"}
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "is expected to return HTTP 401 Unauthorized when trying to update task of another user" do
        other_task = create(:task)
        patch :update, task_list_id: other_task.list.id, id: other_task.id,
          task: {description: "New description"}

        expect(response.status).to        eq 401
        expect(json_response["error"]).to eq 'unauthorized'
      end

      it "is expected to accept unix timestamsp as value of due_date" do
        patch :update, task_list_id: task_list.id, id: task1.id,
          task: { due_date: '2014-10-10' }

        expect(task1.reload.due_date).to eq Date.new(2014, 10, 10)
      end
    end

    describe "#destroy" do
      let(:delete_destroy) do
        delete :destroy, task_list_id: task_list, id: task1.id
      end

      it "is expected to remove the task from database" do
        delete_destroy
        expect { task1.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "is expected to return 200 OK" do
        delete_destroy
        expect(response).to be_success
      end

      it "is expected to raise RecordNotFound when trying to destroy non-existent task" do
        expect {
          delete :destroy, task_list_id: task_list.id, id: 0
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "is expected to return HTTP 401 Unauthorized when trying to delete task of another user" do
        other_task = create(:task)
        delete :destroy, task_list_id: other_task.list.id, id: other_task.id

        expect(response.status).to        eq 401
        expect(json_response["error"]).to eq 'unauthorized'
      end
    end
  end

end
