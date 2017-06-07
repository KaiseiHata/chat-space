class GroupsController < ApplicationController

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: "チャットグループが作成されました。"
    else
      render :new
    end
  end

  def edit
    set_existing_value
  end

  def update
    set_existing_value
    if @group.update(group_params)
      redirect_to root_path(@group), notice: "チャットグループが更新されました。"
    else
      render :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

  def set_existing_value
    @group = Group.find(params[:id])
  end
end
