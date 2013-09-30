# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search_record do
    user_id { User.all.to_a.map(&:id).sample }
    sequence(:queri){|n| "testqueri#{n}" }
  end
end
