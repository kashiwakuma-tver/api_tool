class Series
  require_relative 'auth'
  require_relative '../base'
  require_relative 'api_base'

  def self.series
    api = ApiBase.new('series')
    api.results_of_paging_api
  end

  def self.series_single
    api = ApiBase.new('series', 'sr30gynbcab')
    api.result_of_single_api
  end
end
