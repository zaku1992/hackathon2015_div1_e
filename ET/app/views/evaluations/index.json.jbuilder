json.array!(@evaluations) do |evaluation|
  json.extract! evaluation, :id, :user_id, :toillet_id, :clean, :comfort, :good_smell, :design, :find, :rate, :comment
  json.url evaluation_url(evaluation, format: :json)
end
