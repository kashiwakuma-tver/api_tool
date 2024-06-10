class IngestJob
  require_relative 'api_base'

  def initialize(options = {}, params = {})
    @options = options
    @params = params
  end

  def jobs
    ApiBase.new(@options, @params).exec_api
  end
end
