require 'rails_helper'

RSpec.describe TaskList, :type => :model do
  it "is expected to raise validation error when owner wasn't provided" do
    expect {
      create(:task_list, owner: nil)
    }.to raise_error ActiveRecord::RecordInvalid
  end

  context "for new valid task list" do
    let(:task_list) { create(:task_list) }

    it "is expected to have an empty list of tasks" do
      expect(task_list.tasks).to  eq []
    end
  end
end
