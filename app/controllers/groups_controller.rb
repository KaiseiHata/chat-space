class GroupsController < ApplicationController

def new
  @group = Group.new
end

def create
  @group = Group.create(group_params)
  if @group.save
    redirect_to root_path, notice: "チャットグループが作成されました。"
  else
    render new_group_path
  end
end

def edit

end

def update

end

private
def group_params
  params.require(:group).permit(:name, {user_ids: []})
end
end
