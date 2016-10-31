require "faker"
FactoryGirl.define do
  factory :level do |f|
    f.subject
    f.name {Faker::Name.name}
    f.question_number {Faker::Number.number(2)}
  end
end
