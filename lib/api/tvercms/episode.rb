class Episode
  require_relative 'tver_cms_auth'

  END_POINT = '/api/episode/vod'.freeze

  def self.exec_vod_episode_api
    episode_id = ARGV[0]
    if episode_id
      vod_episode_single(ARGV[0])
    else
      vod_episode_all
    end
  end

  def self.vod_episode_all
    tca = TverCmsAuth.new
    con = tca.make_faraday_header_for_auth
    response = con.get(END_POINT)
    puts response.body
  end

  def self.vod_episode_single(vod_episode_id)
    tca = TverCmsAuth.new
    con = tca.make_faraday_header_for_auth
    response = con.get("#{END_POINT}/#{vod_episode_id}")
    puts response.body
  end
end

Episode.exec_vod_episode_api
