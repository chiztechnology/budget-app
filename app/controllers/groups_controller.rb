class GroupsController < ApplicationController
  def index
    @groups = current_user.groups.includes(:expenses)
  end

  def show
    @group = current_user.groups.find(params[:id])
    @expenses = @group.expenses.order(created_at: :desc)
    @total_amount = @expenses.sum(:amount)
  end

  def expenses; end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.new(group_params)

    if @group.save
      redirect_to groups_path, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
