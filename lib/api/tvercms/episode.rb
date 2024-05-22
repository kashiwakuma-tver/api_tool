class Episode
  require_relative 'auth'
  require_relative '../base'
  require_relative 'api_base'

  def self.episode_vods
    api = ApiBase.new('episode_vod')
    api.results_exec_paging_api
  end

  def self.episode_vod
    api = ApiBase.new('episode_vod', 'id')
    api.results_exec_api
  end

  def self.episode_lives
    api = ApiBase.new('episode_live')
    api.results_exec_paging_api
  end

  def self.episode_live
    api = ApiBase.new('episode_live', 'id')
    api.results_exec_api
  end
end
