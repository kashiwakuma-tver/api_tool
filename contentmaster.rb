require_relative 'requires'

#### ContentMaster ####
### 実行方法 ###
### api_type:実行するAPIを指定する。season, series,episode/vodのいずれか
### target:取得対象として遡りたい年月日時分秒。エポック秒で指定
# yaml = YAML.load_file('meta_url.yaml')
# url = yaml[:dev][:ntv][:url]
# token = yaml[:dev][:ntv][:token]
# puts ContentMaster.new({ url:, token:, api_type: 'episode/vod', id: nil }, { target: Time.new(2024, 6, 21, 13, 59, 59).to_i }).exec_api
