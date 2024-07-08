require_relative 'requires'

KEY_BROADCAST_PROVIDER_IDS = %w[ntv abc ex ktv tver cx mbs tvo ytv tbs].freeze

url = { local: ENV['LOCAL_TVER_CMS_URL'],
        dev: ENV['DEV_TVER_CMS_URL'],
        stg: ENV['STG_TVER_CMS_URL'],
        prd: ENV['PRD_TVER_CMS_URL'] }

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

#### TVerCMSAPI実行に必要なsession cookieを取得 ####
cookie = TverCMS::Auth.new(url[:dev]).manager_tver_cookie_value

#### episode系 ####
# VODエピソード一覧
# puts TverCMS::Episode.new({ api_type: 'episode/vod', cookie:, url: url[:dev] }, { offset: 9000 }).episode_vods

# VODエピソード取得
# puts TverCMS::Episode.new({ api_type: 'episode/vod', cookie:, id: 'epljgx7ad7t', url: url[:dev] }).episode_vod

# LIVEエピソード一覧
# puts TverCMS::Episode.new({ api_type: 'episode/live', cookie:, url: url[:dev] }, { offset: 800 }).episode_lives

# LIVEエピソード取得
# puts TverCMS::Episode.new({ api_type: 'episode/live', cookie:, id: 'leyd4bt4dsv', url: url[:dev] }).episode_live

#### series系 ####
# puts TverCMS::Series.new({ api_type: 'series', cookie:, url: url[:dev] }, { offset: 1500 }).serieses
# puts TverCMS::Series.new({ api_type: 'series', cookie:, id: 'srm04h7ptuh', url: url[:dev] }).series

#### season系 ####
# puts TverCMS::Season.new({ api_type: 'series/sr30gynbcab/season', cookie:, url: url[:dev] }).series_seasons
# puts TverCMS::Season.new({ api_type: 'series/sr30gynbcab/season', id: 'ssyzt9vf3k7', cookie:, url: url[:dev] }).series_season

#### VOD管理系 ####
# puts TverCMS::Vod.new({ api_type: 'vod', cookie:, url: url[:dev] }).vod

## キー局+TVerの情報が一括で欲しい場合
# KEY_BROADCAST_PROVIDER_IDS.each do |bpid|
#   puts TverCMS::Vod.new({ api_type: 'vod', cookie:, url: url[:dev], id: bpid }).vod
# end

#### talent系 ####
results = TverCMS::Talent.new({ api_type: 'talent', cookie:, url: url[:dev] }, { offset: 190_300 }).talents

# talents/:talentidのURLをCSV化する
CSV.open('talents.csv', 'w') do |csv|
  base_url = 'https://tver.jp/talents/'
  jsons = JSON.parse(results.to_json)
  csv << %w[id name group_name]
  jsons.each do |json|
    json.each do |j|
      csv << ["#{base_url}#{j.values[0]}", j.values[2], j.values[29]]
    end
  end
end
