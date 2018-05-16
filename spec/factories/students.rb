require Rails.root.join("spec", "support", "increasing_random.rb")

FactoryBot.define do
  factory :student do
    sequence(:first_name) { |n| "Some fake first name #{n}" }
    sequence(:last_name) { |n| "Some fake last name #{n}" }
    sequence(:email) { |n| "Some fake email #{n}" }
  end
end
