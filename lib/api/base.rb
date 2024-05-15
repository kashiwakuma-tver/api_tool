module BASE
  require 'base64'
  require 'faraday'
  require 'json'
  require 'selenium-webdriver'

  class << self
    def output_json(class_name, result)
      timestamp = Time.now.strftime('%Y%m%d%H%M%S')
      File.open("#{class_name}_#{timestamp}.json", 'w') do |f|
        f.write(result)
      end
    end
  end
end
