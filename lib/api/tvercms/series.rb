class Series
  require_relative 'auth'
  require_relative '../base'
  require_relative 'api_base'

  def self.serieses
    api = ApiBase.new('series')
    params = {}
    api.results_exec_paging_api(params)
  end

  def self.series
    api = ApiBase.new('series')
    api.results_exec_api
  end
end
