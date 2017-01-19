class LocaleResolver
  def self.resolve(headers = {})
    user_locale = (User.current_user.try(:settings) || {}).fetch_path(:display, :locale)
    if user_locale == 'default' || user_locale.nil?
      server_locale = ::Settings.server.locale
      if server_locale == "default" || server_locale.nil?
        headers['Accept-Language']
      else
        server_locale
      end
    else
      user_locale
    end
  end
end
