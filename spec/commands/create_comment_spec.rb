require 'rails_helper'
require 'faker'

RSpec.describe CreateComment do
  let(:user) { create(:user) }
  let(:message) { create(:message) }
  let(:content) { Faker::Football.player }

  let(:command) { CreateComment.new(content, user.id, message.id) }

  describe '#call' do
    it 'should create Comment object' do
      expect{command.call}.to change{Comment.count}.by(1)
    end

    it 'should assign correct fields to Comment' do
      comment = command.call
      expect(comment.content).to eq(content)
      expect(comment.user_id).to eq(user.id)
      expect(comment.message_id).to eq(message.id)
    end
  end

end