require Rails.root.join("spec", "support", "increasing_random.rb")

FactoryBot.define do
  factory :department do
    sequence(:name) { |n| "Some fake name #{n}" }
  end
end
