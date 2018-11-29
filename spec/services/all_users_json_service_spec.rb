require 'rails_helper'
require 'faker'

RSpec.describe AllUsersJson do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  describe "#call" do
    before {
      message1 = create(:message, user_id: user1.id)
      create(:message, user_id: user1.id)
      create(:message, user_id: user1.id)
      create(:message, user_id: user2.id)
      create(:message, user_id: user2.id)

      create(:comment, user_id: user1.id, message_id: message1.id)
      create(:comment, user_id: user1.id, message_id: message1.id)
      create(:comment, user_id: user1.id, message_id: message1.id)
      create(:comment, user_id: user2.id, message_id: message1.id)
    }
    it 'should return proper json response' do
      service = AllUsersJson.new([user1, user2])
      expected_user1 = {
          user: user1.email,
          messages_count: 3,
          comments_count: 3
      }
      expected_user2 = {
          user: user2.email,
          messages_count: 2,
          comments_count: 1
      }
      @expected_array = [expected_user1, expected_user2].to_json
      expect(service.call).to eq(@expected_array)
    end

  end
end