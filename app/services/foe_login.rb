# frozen_string_literal: true

require "selenium-webdriver"

class FoeLogin
  LOGIN_URL = "https://pl-play.forgeofempires.com/?lps_flow=after_glps_shim"

  def initialize(login, password, driver = nil)
    @player_identifier = login
    @password = password
    @driver = driver || Selenium::WebDriver.for(:chrome)
  end

  def login
    @driver.navigate.to LOGIN_URL
    puts "🌐 Strona załadowana: #{@driver.current_url}"
    sleep(0.3)

    begin
      @driver.find_element(id: "page_login_always-visible_input_player-identifier").send_keys(@player_identifier)
      @driver.find_element(id: "page_login_always-visible_input_password").send_keys(@password)
      @driver.find_element(css: 'button[type="submit"]').click
      puts "🚀 Wysłano formularz logowania."

      sleep(1)

      if @driver.page_source.include?("Wyloguj się!")
        puts "✅ Zalogowano pomyślnie!"
        @driver
      else
        puts "❌ Logowanie nieudane."
        nil
      end
    rescue Selenium::WebDriver::Error::TimeoutError
      puts "❌ Formularz logowania się nie pojawił."
      nil
    end
  end
end
