module BASE
  require 'active_support'
  require 'base64'
  require 'csv'
  require 'faraday'
  require 'json'
  require 'selenium-webdriver'
  require 'yaml'

  class << self
    def json_to_csv(class_name, jsons)
      timestamp = Time.now.strftime('%Y%m%d%H%M%S')
      file_name = "#{args[:environment]}_#{class_name}_#{timestamp}.csv"
      CSV.open(file_name, 'w') do |csv|
        # 先にheader作りたいから先んじてjsonからkeyだけ取ってくる
        jsons = JSON.parse(jsons)
        csv << jsons[0][0].keys
        jsons.each do |j|
          j.each do |jj|
            csv << jj.values
          end
        end
      end
    end

    def output_json(class_name, result)
      timestamp = Time.now.strftime('%Y%m%d%H%M%S')
      file_name = "#{args[:environment]}_#{class_name}_#{timestamp}.json"
      File.open(file_name, 'w') do |f|
        f.write(result)
      end
      puts "#{file_name}を出力しました"
    end
  end
end
