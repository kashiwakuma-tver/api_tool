class Episode
  require_relative 'auth'
  require_relative '../base'
  require_relative 'api_base'

  def self.episode_vods
    api = ApiBase.new('episode_vod')
    params = {}
    api.results_exec_paging_api(params)
  end

  def self.episode_vod
    api = ApiBase.new('episode_vod', 'id')
    params = {}
    api.results_exec_api(params)
  end

  def self.episode_lives
    api = ApiBase.new('episode_live')
    params = {}
    api.results_exec_paging_api(params)
  end

  def self.episode_live
    api = ApiBase.new('episode_live', 'id')
    params = {}
    api.results_exec_api(params)
  end
end
