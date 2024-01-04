Rails.application.configure do
  config.lograge.enabled = Settings[:lograge][:enabled] # logger记录新方式 true/false
  config.lograge.keep_original_rails_log = Settings[:lograge][:keep_original] # logger记录旧方式 true/false
end
