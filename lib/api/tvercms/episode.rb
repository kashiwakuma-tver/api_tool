class Episode
  require_relative 'tver_cms_auth'
  require_relative '../base'

  END_POINT = '/api/episode/vod'.freeze

  def exec_vod_episode_api
    episode_id = BASE.args[:id]
    if episode_id
      vod_episode_single(episode_id)
    else
      vod_episode_all
    end
  end

  private

  def vod_episode_all
    tca = TverCmsAuth.new
    con = tca.craete_apiheaders_for_auth
    response = con.get(END_POINT) do |req|
      # requestパラメータ指定したければする
      req.params['']
    end
    result = JSON.pretty_generate(JSON.parse(response.body)['result'])
    BASE.output_json(Series.name, result)
  end

  def vod_episode_single(vod_episode_id)
    tca = TverCmsAuth.new
    con = tca.craete_apiheaders_for_auth
    response = con.get("#{END_POINT}/#{vod_episode_id}") do |req|
      # requestパラメータ指定したければする
      req.params['']
    end
    result = JSON.pretty_generate(JSON.parse(response.body)['result'])
    BASE.output_json(Series.name, result)
  end
end
