class TverCMS
  class Auth
    GOOGLE_AUTH_XPATH = '//*[@id="root"]/div[1]/div[1]/div[2]/div/div[2]/div/div/div[1]/div/div[3]/a/img'.freeze
    USER_DATA_DIR = '/Users/kashiwakuma/selenium_chrome_profile/'.freeze

    def initialize(url, skip_two_factor_auth)
      @url = url
      @skip_two_factor_auth = skip_two_factor_auth
    end

    def manager_tver_cookie_value
      driver_options = Selenium::WebDriver::Chrome::Options.new
      driver_options.add_argument("--user-data-dir=#{USER_DATA_DIR}")
      implicit_wait = 3

      if skip_two_factor_auth?
        driver_options.add_argument('--headless=new')
        driver_options.add_argument('--remote-debugging-port=9222')
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

    private

    def skip_two_factor_auth?
      @skip_two_factor_auth
    end
  end
end
