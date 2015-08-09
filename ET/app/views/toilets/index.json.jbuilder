json.array!(@toilets) do |toilet|
  json.extract! toilet, :id, :name, :lat, :long, :address, :user_id, :western, :japanese, :multi, :urinals, :comment, :ave_rate
  json.url toilet_url(toilet, format: :json)
end
