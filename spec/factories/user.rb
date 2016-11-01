require "faker"
FactoryGirl.define do
  factory :user do |f|
    f.name {Faker::Name.name}
    f.email {Faker::Internet.email}
    f.chatwork_id {Faker::Lorem.characters(10)}
    f.password {"foobar"}
    f.password_confirmation {"foobar"}
    f.role {1}
  end
end
