class Episode
  require_relative 'auth'
  require_relative '../base'
  require_relative 'api_base'

  def initialize
    @args = { api_type: 'episode/vod', content_key: '', environment: 'dev' }
  end

  def episode_vods
    api = ApiBase.new(@args)
    params = {}
    api.exec_paging_api(params)
  end

  def episode_vod
    @args[:content_key] = 'epb3q13akfn'
    api = ApiBase.new(@args)
    params = {}
    api.exec_api(params)
  end

  def episode_lives
    @args[:api_type] = 'episode/live'
    api = ApiBase.new(@args)
    params = {}
    api.exec_paging_api(params)
  end

  def episode_live
    @args[:api_type] = 'episode/live'
    @args[:content_key] = 'lehno0du9th'
    api = ApiBase.new(@args)
    params = {}
    api.exec_api(params)
  end
end
