FactoryBot.define do
  factory :message do
    content { Faker::Football.player }
    user_id { create(:user).id }
  end
end