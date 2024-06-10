require_relative 'lib/api/contentmaster/contentmaster'
require_relative 'create_files'
require_relative 'library'

Dir['lib/api/tvercms/*.rb'].each do |file|
  require_relative file
end

Dir['lib/api/videocloud/*.rb'].each do |file|
  require_relative file
end

###############################################
################# TVerCMS API #################
###############################################

# TVerCMS API実行時に生成するインスタンスに指定する引数について
## optionsとparamsの2種類ある。それぞれハッシュ形式で指定する
### options
#### api_type：実行するAPIを指定する
#### id：取得系のみ。一意のIDを指定する
#### url：実行環境。dev、stg、prodのみ
#### broadcast_provider_id；ContentMasterのみ。取得したい局のIDを指定する
#### need_csv：一覧系のAPIでcsv出力したいときtrueを指定する
### params
### クエリパラメータを指定する。CMSリファレンスに沿って指定する

KEY_BROADCAST_PROVIDER_IDS = %w[ntv abc ex ktv tver cx mbs tvo ytv tbs].freeze

url = { local: ENV['LOCAL_TVER_CMS_URL'],
        dev: ENV['DEV_TVER_CMS_URL'],
        stg: ENV['STG_TVER_CMS_URL'],
        prd: ENV['PRD_TVER_CMS_URL'] }

#### TVerCMSAPI実行に必要なsession cookieを取得 ####
# cookie = Auth.new(url[:dev]).manager_tver_cookie_value

#### episode系 ####
# VODエピソード一覧
# puts Episode.new({ api_type: 'episode/vod', cookie:, url: url[:dev] }, { offset: 9000 }).episode_vods

# VODエピソード取得
# puts Episode.new({ api_type: 'episode/vod', cookie:, id: 'epljgx7ad7t', url: url[:dev] }).episode_vod

# LIVEエピソード一覧
# Episode.new({ api_type: 'episode/live', cookie:, url: url[:dev] }, { offset: 800 }).episode_lives

# LIVEエピソード取得
# Episode.new({ api_type: 'episode/live', cookie:, id: 'leyd4bt4dsv', url: url[:dev] }).episode_live

#### series系 ####
# puts Series.new({ api_type: 'series', cookie:, url: url[:dev] }, { offset: 1500 }).serieses
# puts Series.new({ api_type: 'series', cookie:, id: 'srm04h7ptuh', url: url[:dev] }).series

#### season系 ####
# puts Season.new({ api_type: 'series/sr30gynbcab/season', cookie:, url: url[:dev] }).series_seasons
# puts Season.new({ api_type: 'series/sr30gynbcab/season', id: 'ssyzt9vf3k7', cookie:, url: url[:dev] }).series_season

#### VOD管理系 ####
# Vod.new({ api_type: 'vod', cookie:, url: url[:dev] }).vod
# キー局+TVerの情報が一括で欲しい場合
# KEY_BROADCAST_PROVIDER_IDS.each do |bpid|
#   puts Vod.new({ api_type: 'vod', cookie:, url: url[:dev], id: bpid }).vod
# end

#### ファイル出力したい場合は以下も実行
# CreateFiles.output_json('file_name.json', json)
# CreateFiles.json_to_csv('file_name.csv', json)

#### ContentMaster ####
# yaml = YAML.load_file('meta_url.yaml')
# url = yaml[:dev][:cx][:url]
# token = yaml[:dev][:cx][:token]
# puts ContentMaster.new({ url:, token:, api_type: 'series', id: nil }, { target: '1713315300' }).exec_api

##################################################
################# VideoCloud API #################
##################################################

# VideoCloud API実行時に生成するインスタンスに指定する引数について
## optionsとparamsの2種類ある。それぞれハッシュ形式で指定する
### options
#### api_type：実行するAPIを指定する
#### token：Bearer認証に使うtoken
#### account_id:取得したいデータがあるアカウントのID
#### url：実行環境。dev、stg、prodのみ
### params
### クエリパラメータを指定する。VideoCloudAPIドキュメントに沿って指定する

#### VideoCloud ID及びtoken取得 ####
# yaml = YAML.load_file('videocloud_accounts.yaml')
# account_id = yaml[:tver]
# token = CreateToken.new.exec

#### GetVideo系 ####
# GetVideo一覧
# puts Video.new({ api_type: 'videos', token:, account_id:, url: ENV['VIDEO_CLOUD_CMS_API'] }, { offset: 100 }).videos
# GetVideo取得
# puts Video.new({ api_type: 'videos', token:, account_id:, url: ENV['VIDEO_CLOUD_CMS_API'] }, { q: 'reference_id:tver5pohgn' }).video

#### IngestJob系 ####
# puts IngestJob.new({ api_type: 'ingest_jobs', token:, account_id:, video_id: '6347665424112', url: ENV['VIDEO_CLOUD_CMS_API'] }, { offset: 100 }).jobs
