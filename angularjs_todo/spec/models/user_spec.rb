require 'rails_helper'

RSpec.describe User, :type => :model do
  context "for new valid user" do
    let(:user) { create(:user) }

    it "is expected to have a corresponding task list" do
      expect(user.task_list).to be_a(TaskList)
    end
  end
end
