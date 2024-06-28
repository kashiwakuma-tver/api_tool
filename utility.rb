class Utility
  def self.episode_ids_from_csv(file_name)
    episode_ids = []
    CSV.foreach(file_name, headers: false) do |csv|
      episode_ids << csv[0]
    end
    episode_ids
  end

  def self.json_to_csv(file_name, jsons)
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

  def self.output_json(file_name, result)
    File.open(file_name, 'w') do |f|
      f.write(result)
    end
    puts "#{file_name}を出力しました"
  end
end
