json.array!(@banks) do |bank|
  json.extract! bank, :name, :title_index, :date_index, :value, :column_separator
  json.url bank_url(bank, format: :json)
end
