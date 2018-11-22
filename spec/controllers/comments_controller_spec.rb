require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:message1) {create(:message, user_id: user.id)}
  let(:message2) {create(:message, user_id: user.id)}
  before { sign_in(user) }

  describe '#index' do
    subject { get :index }
    describe 'successfull response' do
      before { subject }

      it { expect(response).to be_successful }
      it { expect(response).to render_template('index') }
    end

    describe 'comments' do
      let(:comment1) { create(:comment, user_id: user.id, message_id: message1.id) }
      let(:comment2) { create(:comment, user_id: user.id, message_id: message2.id) }
      it 'should return all comments if message id is not given' do
        subject
        expect(assigns(:comments)).to match_array([comment1, comment2])
      end

      it 'should return all comments only for chosen message ' do
        get :index, params: { message_id: message1.id }
        expect(assigns(:comments)).to match_array([comment1])
      end
    end
  end

  describe '#show' do
    let(:comment1) { create(:comment, user_id: user.id, message_id: message1.id) }
    before { get :show, params: { id: comment1.id }}

    it 'should return successful response' do
      expect(response).to be_successful
    end
    it 'should render show template' do
      expect(response).to render_template('show')
    end

    it 'should return message' do
      expect(assigns(:comment)).to eq(comment1)
    end
  end

  describe '#new' do
    describe 'with message id' do
      before { get :new, params: { message_id: message1.id } }
      describe 'succesful response' do
        it { expect(response).to be_successful }
        it { expect(response).to render_template('new') }
      end

      context 'comment' do
        it { expect(assigns(:comment)).to be_a(Comment) }
        it { expect(assigns(:comment).persisted?).to eq(false) }
      end
    end

    describe 'without message id' do
      before { get :new }
      describe 'not successful response' do
        it { expect(response).not_to be_successful }
      end
    end
  end

  describe '#create' do
    let(:valid_attributes) {
      { comment: {
          content: Faker::Football.player, user_id: user.id, message_id: message1.id }
      } }
    let(:invalid_attributes) {
      { comment: {
          user_id: user.id, message_id: message1.id
      }
      } }

    context 'valid params' do
      subject { post :create, params: valid_attributes }

      it 'should redirect to message' do
        expect(subject).to redirect_to(comment_path(id: Comment.last.id))
      end

      it 'should create new author' do
        expect { subject }.to change{ Comment.count }.by(1)
      end
    end

    context 'invalid params' do
      subject { post :create, params: invalid_attributes }

      it 'should render new' do
        expect(subject).to render_template('new')
      end

      it 'should not create new author' do
        expect{ subject }.not_to change{ Comment.count }
      end
    end
  end

  describe '#edit' do
    let(:comment1) { create(:comment, user_id: user.id, message_id: message1.id) }
    before { get :edit, params: { id: comment1.id } }

    describe 'succesful response' do
      it { expect(response).to be_successful }
      it { expect(response).to render_template('edit') }
    end

    context 'comment' do
      it { expect(assigns(:comment)).to eq(comment1) }
    end
  end

  describe '#update' do
    let(:content) {Faker::Football.player}
    let(:comment) { create(:comment, user_id: user.id, message_id: message1.id) }
    let(:valid_attributes) { { id: comment.id, comment: { content: content, message_id: message1.id } } }
    let(:invalid_attributes)  { { id: comment.id, comment: { content: '', message_id: message1.id } } }

    context 'valid params' do
      subject { patch :update, params: valid_attributes }

      it 'should redirect to comment' do
        expect(subject).to redirect_to(comment_path(id: comment.id))
      end

      it 'should change content' do
        subject
        expect(comment.reload.content).to eq(content)
      end
    end

    context 'invalid params' do
      subject { patch :update, params: invalid_attributes }

      it 'should render edit' do
        expect(subject).to render_template('edit')
      end

      it 'should not change content' do
        subject
        expect(comment.reload.content).not_to eq(content)
      end
    end
  end

  describe '#destroy' do
    let(:comment1) { create(:comment, user_id: user.id, message_id: message1.id) }
    subject { delete :destroy, params: { id: comment1.id } }

    it 'should redirect to messages index' do
      expect(subject).to redirect_to(comments_path)
    end

    it 'should destroy message' do
      comment1
      expect { subject }.to change{ Comment.count }.by(-1)
    end
  end
end