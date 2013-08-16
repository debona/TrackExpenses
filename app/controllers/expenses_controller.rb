require 'csv'

class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy, :sort]
  before_action :sanitize_offset_parameter, only: :next_to_sort

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
    @categories     = Category.all
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

  # PATCH/PUT /expenses/1/sort
  # PATCH/PUT /expenses/1/sort.json
  def sort
    offset = Category.unsorted.reload.expenses.index(@expense) || 0
    next_parameters = {}
    next_parameters[:offset] = offset if offset > 0

    @expense.category_id = params[:expense][:category_id]

    respond_to do |format|
      if @expense.save
        format.html do
          redirect_to(
            next_to_sort_expenses_path(next_parameters),
            notice: "The expense was sorted as #{@expense.category.name}."
          )
        end
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /expenses/next_to_sort
  def next_to_sort
    @offset = params[:offset]

    expenses        = Category.unsorted.reload.expenses
    @expense        = expenses[@offset]
    @unsorted_count = expenses.count
    @categories     = Category.without_unsorted
  end

  # GET /expenses/select
  def select
    @banks = Bank.all
  end

  def upload
    expenses_csv = params[:csv]
    bank         = Bank.find(params[:bank_id])

    csv_options     = { col_sep: bank.column_separator }
    @expenses_count = 0
    @errors         = []
    @ignored_lines  = []

    expenses_csv.tempfile.each do |line|
      begin
        title, operation_date, value = nil

        CSV.parse(line, csv_options) do |row|
          title           = row[bank.title_index] || ''
          operation_date  = Date.parse(row[bank.date_index] || '')
          value           = Float((row[bank.value_index] || '').gsub(',', '.'))
          raise ArgumentError.new if value > 0 # it's not an expense, ignore it
        end

        @expenses_count += 1

        Expense.new({
          bank:           bank,
          title:          title,
          operation_date: operation_date,
          value:          value
        }).save!

      rescue ArgumentError
        @ignored_lines << line
      rescue CSV::MalformedCSVError
        @ignored_lines << line
      rescue ActiveRecord::ActiveRecordError
        @errors << { line: line, errors:expense.errors }
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
      params.require(:expense).permit(:title, :operation_date, :value, :category_id)
    end

    # Ensures the :offset parameter is set with an integer positive value
    def sanitize_offset_parameter
      params[:offset] = params[:offset].try(:to_i) || 0 # Expect to be an integer
      params[:offset] = 0 if params[:offset] < 0 # Ensure it is included [0, ∞[
    end
end
