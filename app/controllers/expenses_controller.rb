require 'csv'

class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = Expense.all
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render action: 'show', status: :created, location: @expense }
      else
        format.html { render action: 'new' }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :no_content }
    end
  end

  # GET /expenses
  def select
    @banks = Bank.all
  end

  def upload
    expenses_csv = params[:csv]
    bank = Bank.find(params[:bank_id])

    csv_options = { col_sep: bank.column_separator }

    expenses_csv.tempfile.each do |line|
      begin
        CSV.parse(line, csv_options) do |row|
          # TODO: ensure the row is an expense row
          expense = Expense.new
          expense.bank = bank
          expense.title           = row[bank.title_index]
          expense.operation_date  = row[bank.date_index]
          expense.value           = row[bank.value_index]
          expense.save
          # TODO: number of saved expenses ++
          # TODO: log the error
        end
      rescue CSV::MalformedCSVError => error
        puts error
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:title, :operation_date, :value)
    end
end
