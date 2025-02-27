# frozen_string_literal: true

require "selenium-webdriver"
require "test_helper"
require "mocha/minitest"
require_relative "../../app/services/foe_login"

class FoeLoginServiceTest < ActiveSupport::TestCase
  def setup
    @login = "test_user"
    @password = "secret_password"
    @driver = mock("Selenium::WebDriver")
    @element = mock("Selenium::WebDriver::Element")
    @service = FoeLogin.new(@login, @password, @driver)
  end

  test "login should return driver when login is successful" do
    navigation_stub = stub("Navigation")
    navigation_stub.expects(:to).with(FoeLogin::LOGIN_URL)
    @driver.expects(:navigate).returns(navigation_stub)
    @driver.expects(:current_url).returns(FoeLogin::LOGIN_URL)

    @driver.expects(:find_element).with(id: "page_login_always-visible_input_player-identifier").returns(@element)
    @driver.expects(:find_element).with(id: "page_login_always-visible_input_password").returns(@element)
    @driver.expects(:find_element).with(css: 'button[type="submit"]').returns(@element)

    @element.expects(:send_keys).with(@login)
    @element.expects(:send_keys).with(@password)
    @element.expects(:click)

    @driver.expects(:page_source).returns("Wyloguj się!")

    assert_equal @driver, @service.login
  end

  test "login should return nil when login fails" do
    navigation_stub = stub("Navigation")
    navigation_stub.expects(:to).with(FoeLogin::LOGIN_URL)
    @driver.expects(:navigate).returns(navigation_stub)
    @driver.expects(:current_url).returns(FoeLogin::LOGIN_URL)

    @driver.expects(:find_element).with(id: "page_login_always-visible_input_player-identifier").returns(@element)
    @driver.expects(:find_element).with(id: "page_login_always-visible_input_password").returns(@element)
    @driver.expects(:find_element).with(css: 'button[type="submit"]').returns(@element)

    @element.expects(:send_keys).with(@login)
    @element.expects(:send_keys).with(@password)
    @element.expects(:click)

    @driver.expects(:page_source).returns("Błędne dane")

    assert_nil @service.login
  end

  test "login should handle TimeoutError and return nil" do
    navigation_stub = stub("Navigation")
    navigation_stub.stubs(:to)
    @driver.stubs(:navigate).returns(navigation_stub)
    @driver.stubs(:current_url).returns(FoeLogin::LOGIN_URL)

    @driver.expects(:find_element).raises(Selenium::WebDriver::Error::TimeoutError)

    assert_nil @service.login, "Oczekiwano nil przy TimeoutError"
  end
end
