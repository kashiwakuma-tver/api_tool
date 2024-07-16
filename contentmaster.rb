require_relative 'requires'

#### ContentMaster ####
### 実行方法 ###
### api_type:実行するAPIを指定する。season, series,episode/vodのいずれか
### target:取得対象として遡りたい年月日時分秒。エポック秒で指定
yaml = YAML.load_file('meta_url.yaml')
url, token = yaml[:dev][:cx].values
# seasons = ContentMaster.new({ url:, token:, api_type: 'season', id: nil }, { target: Time.new(2024, 6, 21, 13, 59, 59).to_i }).exec_api
# serieses = ContentMaster.new({ url:, token:, api_type: 'series', id: nil }, { target: Time.new(2024, 6, 21, 13, 59, 59).to_i }).exec_api
episodes = ContentMaster.new({ url:, token:, api_type: 'episode/vod' }, { target: Time.new(2024, 6, 30, 5, 50, 0).to_i }).exec_api
# episode = ContentMaster.new({ url:, token:, api_type: 'episode/vod/40lf/5kp7/F5kp7kawp_r7i'}).exec_api

# Utility.output_json('season.json', season.to_json)
# Utility.output_json('series.json', series.to_json)
Utility.output_json('episodes.json', episodes.to_json)
# Utility.output_json('episode.json', episode.to_json)
