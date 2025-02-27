# frozen_string_literal: true

require "selenium-webdriver"

class ChooseWorld
  WORLD_PAGE = "https://pl0.forgeofempires.com/page/"

  def initialize(driver)
    @driver = driver
  end

  def choose_world
    @driver.navigate.to WORLD_PAGE
    puts "🌍 Przejście do strony wyboru świata: #{WORLD_PAGE}"
    sleep(0.3)

    begin
      @driver.find_element(id: "play_now_button").click
      puts "✅ Kliknięto przycisk 'Graj teraz'."
      sleep(0.3)
      @driver.find_element(link_text: "Houndsmoor").click
      puts "🌎 Wybrano świat 'Houndsmoor'."

    rescue Selenium::WebDriver::Error::NoSuchElementError => e
      puts "❌ Nie znaleziono wymaganego elementu: #{e.message}"
    rescue Selenium::WebDriver::Error::TimeoutError
      puts "⏳ Czas oczekiwania na element minął."
    rescue => e
      puts "⚠️ Wystąpił inny błąd: #{e.message}"
    end
  end
end
