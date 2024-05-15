class TverCmsAuth
  require_relative '../base'

  GOOGLE_AUTH_XPATH = '//*[@id="root"]/div[1]/div[1]/div[2]/div/div[2]/div/div/div[1]/div/div[3]/a/img'.freeze
  USER_DATA_DIR = '/Users/kashiwakuma/selenium_chrome_profile/'.freeze

  def make_faraday_header_for_auth
    apiheaders = Faraday.new(url: ENV['DEV_TVER_CMS_URL']) do |c| # rubocop:disable Style/RedundantAssignment
      c.headers['Content-Type'] = 'application/json'
      c.headers['cookie'] = "manager-tver=#{cookie_manager_tver}"
    end
    apiheaders
  end

  private

  def cookie_manager_tver
    driver_options = Selenium::WebDriver::Chrome::Options.new
    driver_options.add_argument("--user-data-dir=#{USER_DATA_DIR}")
    implicit_wait = 3

    if Dir.exist?("#{USER_DATA_DIR}/AutofillStates")
      driver_options.add_argument('--headless=new')
      driver_options.add_argument('--remote-debugging-port=9222')
      implicit_wait = 0
    end

    driver = Selenium::WebDriver.for(:chrome, options: driver_options)
    driver.manage.timeouts.implicit_wait = implicit_wait

    driver.get(ENV['DEV_TVER_CMS_URL'])

    unless driver.find_elements(:xpath, GOOGLE_AUTH_XPATH).empty?
      gauth_element = driver.find_element(:xpath, GOOGLE_AUTH_XPATH)
      gauth_element.click
      sleep(60)
    end

    driver.manage.cookie_named('manager-tver')[:value]
  end
end
