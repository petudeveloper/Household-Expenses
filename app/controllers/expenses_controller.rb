class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: %i[show edit update destroy]

  # GET /expenses or /expenses.json
  def index
    @expenses = Expense.where(user_id: current_user.id).order(created_at: :desc).includes(:groups)
    @amount = @expenses.sum('amount')
  end

  def external
    @expenses = Expense.order(created_at: :desc).left_outer_joins(:group_expenses)
    @amount = @expenses.sum('amount')
  end

  # GET /expenses/1 or /expenses/1.json
  def show; end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # POST /expenses or /expenses.json
  def create
    @expense = current_user.expenses.create(expense_params)
    redirect_to @expense, notice: 'Your expense was successfully created.' if @expense.save
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_expense
    @expense = Expense.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:name, :amount, :user_id, group_ids: [])
  end
end
