require_relative 'lib/api/video_cloud'
require_relative 'lib/api/tvercms/episode'
require_relative 'lib/api/tvercms/series'
require_relative 'lib/api/tvercms/season'
require_relative 'lib/api/tvercms/vod'
require_relative 'lib/api/contentmaster/contentmaster'

# インスタンス生成時に指定する引数について
## optionsとparamsの2種類ある。それぞれハッシュ形式で指定する
### options
#### api_type：実行するAPIを指定する
#### id：取得系のみ。一意のIDを指定する
#### environment：実行環境。dev、stg、prodのみ
#### broadcast_provider_id；ContentMasterのみ。取得したい局のIDを指定する
#### need_csv：一覧系のAPIでcsv出力したいときtrueを指定する
### params
### クエリパラメータを指定する。CMSリファレンスに沿って指定する

#### episode系 ####
# VODエピソード一覧
# Episode.new({ api_type: 'episode/vod', id: nil, environment: 'dev', need_csv: true }).episode_vods

# VODエピソード取得
# Episode.new({ api_type: 'episode/vod', id: 'epljgx7ad7t', environment: 'dev' }).episode_vod

# LIVEエピソード一覧
# Episode.new({ api_type: 'episode/live', id: nil, environment: 'dev', need_csv: true}).episode_lives

# LIVEエピソード取得
# Episode.new({ api_type: 'episode/live', id: 'leyd4bt4dsv', environment: 'dev' }).episode_live

#### series系 ####
# Series.new({ api_type: 'series', id: nil, environment: 'dev' }).serieses
# Series.new({ api_type: 'series', id: 'srm04h7ptuh', environment: 'dev' }).series

#### season系 ####
# Season.new({ api_type: 'series/sr30gynbcab/season', id: nil, environment: 'dev' }).series_seasons
# Season.new({ api_type: 'series/sr30gynbcab/season', id: 'ssyzt9vf3k7', environment: 'dev' }).series_season

#### VOD管理系 ####
# Vod.new({ api_type: 'vod', id: nil, environment: 'dev' }).vod

#### ContentMaster ####
# ContentMaster.new({ environment: 'dev', broadcast_provider_id: 'cx', api_type: 'series', id: nil }, { target: '1713315300' }).exec_api
