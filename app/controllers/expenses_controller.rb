class ExpensesController < ApplicationController
  def index
    @expenses = @group.expenses.order(created_at: :desc)
    @total_amount = @expenses.sum(:amount)
  end

  def new
    @expense = Expense.new
    @groups = current_user.groups.includes(:expenses)
  end

  def create
    @new_expense = Expense.new(expense_params)
    if @new_expense.group_ids.empty?
      flash[:error] = 'At one least category must be selected'
      redirect_to new_group_expense_path(group_id: params[:group_id])
    else
      @expense = Expense.new(name: @new_expense.name, amount: @new_expense.amount)
      @expense.user = current_user
      @new_expense.group_ids.each do |group_id|
        @group = current_user.groups.find(group_id)
        @group.expenses << @expense
      end
      @group = Group.find(params[:group_id])
      if @expense.save
        redirect_to group_path(@group)
      else
        @groups = current_user.groups
        render :new
      end
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, group_ids: [])
  end
end
