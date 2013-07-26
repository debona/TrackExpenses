json.array!(@expenses) do |expense|
  json.extract! expense, :title, :operation_date, :value
  json.url expense_url(expense, format: :json)
end
