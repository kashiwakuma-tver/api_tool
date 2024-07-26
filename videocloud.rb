require_relative 'requires'

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
account_id = ENV['VIDEO_CLOUD_ACCOUNT_TVER']
token = VideoCloud::CreateToken.new.access_token

#### GetVideo系 ####
## GetVideo一覧
puts VideoCloud::Video.new({ api_type: 'videos', token:, account_id:, url: ENV['VIDEO_CLOUD_CMS_API'] }, { offset: 100 }).videos
## GetVideo取得
puts VideoCloud::Video.new({ api_type: 'videos', token:, account_id:, url: ENV['VIDEO_CLOUD_CMS_API'] }, { q: 'reference_id:tver5pohgn' }).video

#### IngestJob系 ####
puts VideoCloud::IngestJob.new({ api_type: 'ingest_jobs', token:, account_id:, video_id: '6347665424112', url: ENV['VIDEO_CLOUD_CMS_API'] }, { offset: 100 }).jobs
