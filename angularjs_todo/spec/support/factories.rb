FactoryGirl.define do
  factory :user, aliases: [:owner] do
    email    "test@test.com"
    password "password"
  end

  factory :task_list do
    owner
  end
end
