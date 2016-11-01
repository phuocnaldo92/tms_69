require "faker"
FactoryGirl.define do
  factory :subject do
    name{Faker::Name.name}
    duration{Faker::Number.number(2)}
  end
end
