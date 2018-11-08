# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require Rails.root.join("spec", "support", "increasing_random.rb")

FactoryBot.define do
  factory :department do
    sequence(:name) { |n| "Some fake name #{n}" }
  end
end
