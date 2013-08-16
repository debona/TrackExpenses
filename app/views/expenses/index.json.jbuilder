json.array!(@expenses) do |expense|
  json.extract! expense, :bank, :title, :operation_date, :value, :category
  json.url expense_url(expense, format: :json)
end
