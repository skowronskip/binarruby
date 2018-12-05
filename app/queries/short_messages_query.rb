class ShortMessagesQuery
  def call
    short_messages
  end

  private

  def short_messages
    Message.where('length(content) < 20')
  end
end