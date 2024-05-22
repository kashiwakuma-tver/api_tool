module BASE
  require 'base64'
  require 'csv'
  require 'faraday'
  require 'json'
  require 'selenium-webdriver'
  require 'yaml'

  class << self
    def args
      args = { environment: ARGV[0], id: ARGV[1] }
      # args unless args_check(args)
    end

    def json_to_csv(class_name, jsons)
      timestamp = Time.now.strftime('%Y%m%d%H%M%S')
      file_name = "#{args[:environment]}_#{class_name}_#{timestamp}.csv"
      CSV.open(file_name, 'w') do |csv|
        json = JSON.parse(jsons)
        json.each do |j|
          j.each do |jj|
            csv << jj.keys
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

    private

    # def args_check(args)
    #   if args[:id]
    #     unless (args[:id].start_with?(/ep|sr/) && args[:id].length == 10)
    #       puts 'エピソードまたはシリーズのIDを正しくいれてください'
    #       exit
    #     end
    #   end
    # end
  end
end
