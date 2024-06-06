class Auth
  require 'active_support/all'
  require 'selenium-webdriver'

  GOOGLE_AUTH_XPATH = '//*[@id="root"]/div[1]/div[1]/div[2]/div/div[2]/div/div/div[1]/div/div[3]/a/img'.freeze
  USER_DATA_DIR = '/Users/kashiwakuma/selenium_chrome_profile/'.freeze

  def initialize(url)
    @url = url
  end

  def manager_tver_cookie_value
    driver_options = Selenium::WebDriver::Chrome::Options.new
    driver_options.add_argument("--user-data-dir=#{USER_DATA_DIR}")
    implicit_wait = 3

    # Chromeユーザプロファイルのディレクトリが空じゃないかで判定なので
    # 具体的なファイル名は適当だが、見直しが必要
    if Dir.exist?("#{USER_DATA_DIR}/AutofillStates")
      driver_options.add_argument('--headless=new')
      driver_options.add_argument('--remote-debugging-port=9222')
      implicit_wait = 0
    end

    driver = Selenium::WebDriver.for(:chrome, options: driver_options)
    # seleniumが画面開いてcookie取得するまでに若干待機が必要
    driver.manage.timeouts.implicit_wait = implicit_wait

    driver.get(@url)

    unless driver.find_elements(:xpath, GOOGLE_AUTH_XPATH).empty?
      gauth_element = driver.find_element(:xpath, GOOGLE_AUTH_XPATH)
      gauth_element.click
      # 手動でGoogleログイン操作が必要なので60秒sleepする
      sleep(60)
    end

    driver.manage.cookie_named('manager-tver')[:value]
  end
end
