class Season
  require_relative 'auth'
  require_relative '../base'
  require_relative 'api_base'

  def self.seasons
    api = ApiBase.new('season', 'sr30gynbcab/season')
    api.results_exec_api
  end
end
