class AllUsersJson
  def initialize(users)
    @users = users
  end

  def call
    return 'There is any user' if @users.length == 0
    users_to_json
  end

  private

  def users_to_json
    @users = @users.map do |user|
      {user: user.email, messages_count: user.messages.count, comments_count: user.comments.count}
    end
    @users.to_json
  end
end