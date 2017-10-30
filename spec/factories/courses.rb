# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require Rails.root.join("spec", "support", "increasing_random.rb")

FactoryBot.define do
  factory :course do
    sequence(:title) { |n| "Some fake title #{n}" }
  end
end
