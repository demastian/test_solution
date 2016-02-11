CarrierWave.configure do |config|
  if Rails.env.test? or Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
  else
    config.storage = :fog
    config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        region:                ENV['AWS_S3_REGION'], # optional, defaults to 'us-east-1'
    }

    config.fog_directory = ENV['AWS_S3_BUCKET_NAME']
  end
end
