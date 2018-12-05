class CreateComment
  include ::ActiveModel::Validations

  # validates :content, presence: true, length: { maximum: 140 }
  # validates :user_id, :message_id, presence: true

  def initialize(content, user_id, message_id)
    @content = content
    @user_id = user_id
    @message_id = message_id
  end

  def call
    validate!
    create_comment
  end

  private

  def create_comment
    # CarOrder is a model
    Comment.create(
        content: @content,
        user_id: @user_id,
        message_id: @message_id
    )
  end
end