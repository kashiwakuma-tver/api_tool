class Season
  require_relative 'auth'
  require_relative '../base'
  require_relative 'api_base'

  def initialize
    @args = { api_type: 'season', content_key: '', environment: 'dev' }
  end

  def series_seasons(series_key)
    @args[:api_type] = 'series/' + "#{series_key}/" + 'season'
    api = ApiBase.new(@args)
    params = {}
    api.exec_api(params)
  end

  def series_season(series_key)
    @args[:api_type] = 'series/' + "#{series_key}/" + 'season'
    @args[:content_key] = 'ssyzt9vf3k7'
    api = ApiBase.new(@args)
    params = {}
    api.exec_api(params)
  end

  def season
    @args[:content_key] = 'ssyzt9vf3k7'
    api = ApiBase.new(@args)
    params = {}
    api.exec_api(params)
  end
end
