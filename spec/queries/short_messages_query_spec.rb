require 'rails_helper'
require 'faker'

RSpec.describe ShortMessagesQuery do
  let(:user) { create(:user) }

  describe '#call' do
    let(:message1) { create(:message, user_id: user.id, content: 'Only few char') }
    let(:message2) { create(:message, user_id: user.id, content: 'Only few char') }
    let(:message3) { create(:message, user_id: user.id, content: 'Only few char') }
    let(:message4) { create(:message, user_id: user.id, content: 'Definetely more than 20 characters message') }
    let(:message5) { create(:message, user_id: user.id, content: 'Definetely more than 20 characters message') }
    let(:message6) { create(:message, user_id: user.id, content: 'Definetely more than 20 characters message') }
    let(:message7) { create(:message, user_id: user.id, content: 'Definetely more than 20 characters message') }
    let(:query) { ShortMessagesQuery.new }

    it 'should return today day' do
      expected_array = [message1, message2, message3]
      expect(query.call).to eq(expected_array)
      expect(query.call.count).to eq(3)
    end
  end
end