require "faker"
FactoryGirl.define do
  factory :exam do
    user
    subject
  end
end
