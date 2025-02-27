# frozen_string_literal: true

require "test_helper"
require "mocha/minitest"
require_relative "../../app/services/choose_world"

class ChooseWorldServiceTest < ActiveSupport::TestCase
  def setup
    @driver = mock("Selenium::WebDriver")
    @element = mock("Selenium::WebDriver::Element")
    @service = ChooseWorld.new(@driver)
  end

  test "choose_world should click 'Play Now' and select world 'Houndsmoor'" do
    @driver.expects(:navigate).returns(@driver)
    @driver.expects(:to).with(ChooseWorld::WORLD_PAGE)

    @driver.expects(:find_element).with(id: "play_now_button").returns(@element)
    @element.expects(:click)

    @driver.expects(:find_element).with(link_text: "Houndsmoor").returns(@element)
    @element.expects(:click)

    @service.choose_world
  end

  test "choose_world should handle NoSuchElementError and print error" do
    @driver.expects(:navigate).returns(@driver)
    @driver.expects(:to).with(ChooseWorld::WORLD_PAGE)

    @driver.expects(:find_element).with(id: "play_now_button").raises(Selenium::WebDriver::Error::NoSuchElementError)

    assert_output(/Nie znaleziono wymaganego elementu/) do
      @service.choose_world
    end
  end

  test "choose_world should handle TimeoutError and print timeout message" do
    @driver.expects(:navigate).returns(@driver)
    @driver.expects(:to).with(ChooseWorld::WORLD_PAGE)

    @driver.expects(:find_element).with(id: "play_now_button").raises(Selenium::WebDriver::Error::TimeoutError)

    assert_output(/Czas oczekiwania na element minął/) do
      @service.choose_world
    end
  end

  test "choose_world should handle generic errors and print error message" do
    @driver.expects(:navigate).returns(@driver)
    @driver.expects(:to).with(ChooseWorld::WORLD_PAGE)

    @driver.expects(:find_element).with(id: "play_now_button").raises(StandardError.new("Inny błąd"))

    assert_output(/Wystąpił inny błąd/) do
      @service.choose_world
    end
  end
end
