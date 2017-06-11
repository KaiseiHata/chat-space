class MessagesController < ApplicationController
  before_action :set_existing_value, only: [:index, :create]
  def index
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)
    redirect_to group_messages_path(@message.group_id)
  end

  private
  def set_existing_value
    @groups = current_user.groups
    @group = Group.find(params[:group_id])
    @messages = @group.messages
  end

  def message_params
    params.require(:message).permit(:body, :image).merge(group_id: @group.id, user_id: current_user.id)
  end
end
