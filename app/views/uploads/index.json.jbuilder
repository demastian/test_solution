json.array!(@uploads) do |upload|
  json.extract! upload, :id, :file, :attribute_name
  json.url upload_url(upload, format: :json)
end
