Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.full_host = Rails.env
    .production? ? Settings.heroku : Settings.host
end
