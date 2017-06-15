module MessagesHelper
  def time(message)
    message.created_at.to_s(:jp)
  end
end