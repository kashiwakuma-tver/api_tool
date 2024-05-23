class Series
  require_relative 'auth'
  require_relative '../base'
  require_relative 'api_base'

  def initialize
    @args = { api_type: 'series', content_key: '', environment: 'dev' }
  end

  def serieses
    api = ApiBase.new(@args)
    params = {}
    api.results_exec_paging_api(params)
  end

  def series
    @args[:content_key] = 'sr30gynbcab'
    api = ApiBase.new(@args)
    params = {}
    api.results_exec_api(params)
  end
end
