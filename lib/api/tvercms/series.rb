class Series
  require_relative 'auth'
  require_relative '../base'
  require_relative 'api_base'

  def initialize(options = {}, params = {})
    @options = options
    @params = params
  end

  def serieses
    ApiBase.new(@options, @params).exec_paging_api
  end

  def series
    ApiBase.new(@options, @params).exec_api
  end
end
