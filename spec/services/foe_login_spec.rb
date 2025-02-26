# frozen_string_literal: true

require "selenium-webdriver"
require "spec_helper"
require_relative "../../app/services/foe_login"

RSpec.describe FoeLogin do
  let(:login)     { "test_user" }
  let(:password)  { "secret_password" }
  let(:driver)    { instance_double(Selenium::WebDriver::Driver) }
  let(:element)   { instance_double(Selenium::WebDriver::Element) }

  subject { described_class.new(login, password, driver) }

  before do
    allow(driver).to receive_message_chain(:navigate, :to)
    allow(driver).to receive(:current_url).and_return(FoeLogin::LOGIN_URL)
  end

  describe "#login" do
    context "gdy logowanie przebiega pomyślnie" do
      before do
        allow(driver).to receive(:find_element)
          .with(id: "page_login_always-visible_input_player-identifier")
          .and_return(element)
        allow(driver).to receive(:find_element)
          .with(id: "page_login_always-visible_input_password")
          .and_return(element)
        allow(driver).to receive(:find_element)
          .with(css: 'button[type="submit"]')
          .and_return(element)

        allow(element).to receive(:send_keys)
        allow(element).to receive(:click)

        allow(driver).to receive(:page_source).and_return("Wyloguj się!")
      end

      it "zwraca driver po udanym logowaniu" do
        expect(subject.login).to eq(driver)
      end
    end

    context "gdy logowanie nie jest udane" do
      before do
        allow(driver).to receive(:find_element)
          .with(id: "page_login_always-visible_input_player-identifier")
          .and_return(element)
        allow(driver).to receive(:find_element)
          .with(id: "page_login_always-visible_input_password")
          .and_return(element)
        allow(driver).to receive(:find_element)
          .with(css: 'button[type="submit"]')
          .and_return(element)

        allow(element).to receive(:send_keys)
        allow(element).to receive(:click)

        allow(driver).to receive(:page_source).and_return("Inna zawartość strony")
      end

      it "zwraca nil gdy logowanie się nie powiodło" do
        expect(subject.login).to be_nil
      end
    end

    context "gdy wystąpi TimeoutError" do
      before do
        allow(driver).to receive(:find_element).and_raise(Selenium::WebDriver::Error::TimeoutError)
      end

      it "obsługuje wyjątek i zwraca nil" do
        expect { subject.login }.not_to raise_error
        expect(subject.login).to be_nil
      end
    end
  end
end
