require 'rails_helper'

RSpec.describe TaskListsController, :type => :controller do
  describe "#show" do
    it "is expected to return 200 for existing task list" do
      task_list = create(:task_list)
      get :show, id: task_list.id

      expect(response).to be_ok
    end

    it "is expected to return 404 when task list doesn't exist" do
      expect {
        get :show, id: 1
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
