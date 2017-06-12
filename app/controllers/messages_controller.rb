class MessagesController < ApplicationController
  before_action :set_existing_value, only: [:index, :create]
  def index
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to group_messages_path(@message.group_id)
    else
      flash.now[:alert] = "メッセージが投稿されませんでした"
      render :index
    end
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
