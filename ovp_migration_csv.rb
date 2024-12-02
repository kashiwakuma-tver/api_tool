require_relative 'requires'

video_cloud_ref_ids = []

CSV_FILE_PATH = 'vod_episodes_20241120100135.csv'.freeze
account_id = ENV['VIDEO_CLOUD_ACCOUNT_ABC']

CSV.foreach(CSV_FILE_PATH, headers: true) do |row|
  video_cloud_ref_ids.push(row[38])
end

CSV_HEADERS = %w[ref_id name description publish_start_at publish_end_at poster_image ad_fields].freeze

CSV.open("registration_for_streaks_#{account_id}.csv", 'w') do |csv|
  csv << CSV_HEADERS
end

token = VideoCloud::CreateToken.new.access_token

video_cloud_ref_ids.each do |ref_id|
  video = VideoCloud::Video.new({ api_type: 'videos', token:, account_id:, url: ENV['VIDEO_CLOUD_CMS_API'] }, { q: "reference_id: #{ref_id}" }).video.to_json
  info = [JSON.parse(video)[0]['reference_id'], JSON.parse(video)[0]['name'], JSON.parse(video)[0]['description'], JSON.parse(video)[0]['schedule']['starts_at'], JSON.parse(video)[0]['schedule']['ends_at'], '', JSON.parse(video)[0]['custom_fields']]
  CSV.open("registration_for_streaks_#{account_id}.csv", 'a') do |csv|
    csv << info
  end
end
