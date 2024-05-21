class Season
  require_relative 'auth'
  require_relative '../base'
  require_relative 'api_base'

  def self.season
    api = ApiBase.new('season', 'sr30gynbcab/season')
    api.result_of_single_api
  end
end
