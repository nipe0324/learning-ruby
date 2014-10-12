FactoryGirl.define do
  factory :user, aliases: [:owner] do
    sequence(:email)    { |n| "test#{n}@test.com" }
    password            "password"
  end

  factory :task_list, aliases: [:list] do
    owner
  end

  factory :task do
    list
    sequence(:description) { |n| "Task #{n}" }
  end
end
