class Auth
  GOOGLE_AUTH_XPATH = '//*[@id="root"]/div[1]/div[1]/div[2]/div/div[2]/div/div/div[1]/div/div[3]/a/img'.freeze
  USER_DATA_DIR = '/Users/kashiwakuma/selenium_chrome_profile/'.freeze

  def initialize(environment)
    @environment = environment
  end

  def define_url
    case @environment
    when 'local'
      ENV['LOCAL_TVER_CMS_URL']
    when 'dev'
      ENV['DEV_TVER_CMS_URL']
    when 'stv'
      ENV['STG_TVER_CMS_URL']
    when 'prd'
      ENV['PRD_TVER_CMS_URL']
    else
      exit
    end
  end

  def craete_apiheaders_for_auth
    puts "cookie_manager_tver: #{manager_tver_cookie_value}"
    url = define_url
    puts "url: #{url}"
    apiheaders = Faraday.new(url: define_url) do |c| # rubocop:disable Style/RedundantAssignment
      c.headers['Content-Type'] = 'application/json'
      c.headers['cookie'] = "manager-tver=#{manager_tver_cookie_value}"
    end
    apiheaders
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

    driver.get(define_url)

    unless driver.find_elements(:xpath, GOOGLE_AUTH_XPATH).empty?
      gauth_element = driver.find_element(:xpath, GOOGLE_AUTH_XPATH)
      gauth_element.click
      # 手動でGoogleログイン操作が必要なので60秒sleepする
      sleep(60)
    end

    driver.manage.cookie_named('manager-tver')[:value]
  end
end
