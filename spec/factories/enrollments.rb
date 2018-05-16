require Rails.root.join("spec", "support", "increasing_random.rb")

FactoryBot.define do
  factory :enrollment do
    sequence(:student_id) { |n| "Some fake student ID #{n}" }
    sequence(:course_id) { |n| "Some fake course ID #{n}" }
  end
end
