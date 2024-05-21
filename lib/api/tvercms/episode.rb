class Episode
  require_relative 'auth'
  require_relative '../base'
  require_relative 'api_base'

  def self.episode_vods
    api = ApiBase.new('episode_vod')
    api.results_exec_paging_api
  end

  def self.episode_vod
    api = ApiBase.new('episode_vod', 'epacfu64bq7')
    api.results_exec_api
  end
end
