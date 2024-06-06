class GetVideo
  require_relative 'api_base'

  def initialize(options = {}, params = {})
    @options = options
    @params = params
  end

  def get_videos
    ApiBase.new(@options, @params).exec_paging_api
  end

  def get_video
    ApiBase.new(@options, @params).exec_api
  end
end