require "uri"
require "cgi"

class TokenExtractor
  def initialize(driver)
    @driver = driver
  end

  def extract_token
    current_url = @driver.current_url
    uri = URI.parse(current_url)
    return nil if uri.query.nil?
    params = CGI.parse(uri.query)
    params["h"]&.first
  end
end
