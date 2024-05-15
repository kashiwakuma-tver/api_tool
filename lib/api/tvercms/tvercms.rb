class TverCms
  require_relative '../base'

  GOOGLE_AUTH_XPATH = '//*[@id="root"]/div[1]/div[1]/div[2]/div/div[2]/div/div/div[1]/div/div[3]/a/img'.freeze
  def cookie_tvercms
    driver_options = Selenium::WebDriver::Chrome::Options.new
    driver_options.add_argument('--user-data-dir=/Users/kashiwakuma/selenium_chrome_profile/')

    driver = Selenium::WebDriver.for :chrome, options: driver_options
    driver.manage.timeouts.implicit_wait = 3

    driver.get(ENV['DEV_TVER_CMS_URL'])

    unless driver.find_elements(:xpath, GOOGLE_AUTH_XPATH).empty?
      gauth_element = driver.find_element(:xpath, GOOGLE_AUTH_XPATH)
      gauth_element.click
      sleep(30)
    end

    driver.manage.cookie_named('manager-tver')[:value]
  end
end

puts TverCms.cookie_tvercms
