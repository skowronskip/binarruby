require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'should have proper attributes' do
    expect(subject.attributes).to include('content', 'created_at', 'updated_at', 'user_id')
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_most(140) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:comments) }
    it { is_expected.to belong_to(:user) }
  end
end