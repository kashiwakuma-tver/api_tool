require_relative 'lib/api/video_cloud'
require_relative 'lib/api/tvercms/auth'
require_relative 'lib/api/tvercms/episode'
require_relative 'lib/api/tvercms/series'
require_relative 'lib/api/tvercms/season'
require_relative 'lib/api/tvercms/vod'
require_relative 'lib/api/contentmaster/contentmaster'

KEY_BROADCAST_PROVIDER_IDS = %w[ntv abc ex ktv tver cx mbs tvo ytv tbs].freeze

url_hash = { local: ENV['LOCAL_TVER_CMS_URL'],
             dev: ENV['DEV_TVER_CMS_URL'],
             stg: ENV['STG_TVER_CMS_URL'],
             prd: ENV['PRD_TVER_CMS_URL']
            }

# インスタンス生成時に指定する引数について
## optionsとparamsの2種類ある。それぞれハッシュ形式で指定する
### options
#### api_type：実行するAPIを指定する
#### id：取得系のみ。一意のIDを指定する
#### url：実行環境。dev、stg、prodのみ
#### broadcast_provider_id；ContentMasterのみ。取得したい局のIDを指定する
#### need_csv：一覧系のAPIでcsv出力したいときtrueを指定する
### params
### クエリパラメータを指定する。CMSリファレンスに沿って指定する

#### TVerCMSAPI実行に必要なsession cookieを取得 ####
cookie = Auth.new(url_hash[:dev]).manager_tver_cookie_value

#### episode系 ####
# VODエピソード一覧
puts Episode.new({ api_type: 'episode/vod', cookie:, offset: 9000, url: url_hash[:dev] }).episode_vods

# VODエピソード取得
puts Episode.new({ api_type: 'episode/vod', cookie:,  id: 'epljgx7ad7t', url: url_hash[:dev] }).episode_vod

# LIVEエピソード一覧
puts Episode.new({ api_type: 'episode/live', cookie:, offset: 0, url: url_hash[:dev] }).episode_lives

# LIVEエピソード取得
# Episode.new({ api_type: 'episode/live', cookie: cookie, id: 'leyd4bt4dsv', url: url_hash[:dev]  }).episode_live

#### series系 ####
# Series.new({ api_type: 'series', cookie:, url: url_hash[:dev] }).serieses
# Series.new({ api_type: 'series', cookie:, id: 'srm04h7ptuh', url: url_hash[:dev] }).series

#### season系 ####
# Season.new({ api_type: 'series/sr30gynbcab/season', cookie:, url: url_hash[:dev] }).series_seasons
# Season.new({ api_type: 'series/sr30gynbcab/season', id: 'ssyzt9vf3k7', cookie:, url: url_hash[:dev] }).series_season

#### VOD管理系 ####
# Vod.new({ api_type: 'vod', cookie:, url: url_hash[:dev] }).vod
# キー局+TVerの情報が一括で欲しい場合
# KEY_BROADCAST_PROVIDER_IDS.each do |bpid|
#   puts Vod.new({ api_type: 'vod', cookie:, url: url_hash[:dev], id: bpid }).vod
# end

#### ファイル出力したい場合は以下も実行
# BASE.output_json('file_name.json', json)
# BASE.json_to_csv('file_name.csv', json)

#### ContentMaster ####
# ContentMaster.new({ url: url_hash[:dev], broadcast_provider_id: 'cx', api_type: 'series', id: nil }, { target: '1713315300' }).exec_api
