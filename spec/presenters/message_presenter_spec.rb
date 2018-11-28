require 'rails_helper'
require 'faker'

RSpec.describe MessagePresenter do
  let(:user) { create(:user) }
  let(:message) { create(:message, user_id: user.id)}

  describe '#day_of_week' do
    let(:message_presenter) { MessagePresenter.new(message) }

    it 'should return today day' do
      expect(message_presenter.day_of_week).to eq(DateTime.now.strftime("%A"))
    end
  end
end