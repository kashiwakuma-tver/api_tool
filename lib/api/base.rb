module BASE
  require 'active_support/all'
  require 'base64'
  require 'csv'
  require 'faraday_middleware'
  require 'json'
  require 'selenium-webdriver'
  require 'time'
  require 'yaml'

  class << self
    def json_to_csv(file_name, jsons)
      CSV.open(file_name, 'w') do |csv|
        jsons = JSON.parse(jsons)
        # 先にheader作りたいから先んじてjsonからkeyだけ取ってくる
        csv << jsons[0][0].keys
        jsons.each do |json|
          json.each do |j|
            csv << j.values
          end
        end
      end
      puts "#{file_name}を出力しました"
    end

    def output_json(file_name, result)
      File.open(file_name, 'w') do |f|
        f.write(result)
      end
      puts "#{file_name}を出力しました"
    end
  end
end
