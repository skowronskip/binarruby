FactoryBot.define do
  factory :comment do
    content { Faker::Football.player }
    message_id { create(:message).id }
    user_id { create(:user).id }
  end
end