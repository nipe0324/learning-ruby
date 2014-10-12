require 'rails_helper'

RSpec.describe Api::TaskListsController, :type => :controller do

  describe "#index" do
    context "for user that has a task list" do
      let(:user)  { create(:user) }
      before      { sign_in(user) }

      it "is expected to return json of array of those task lists" do
        get :index
        tasks = JSON.parse(response.body)

        expect(tasks).to eq [{ 'id' => user.task_list.id }]
      end
    end
  end

end
