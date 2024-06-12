class VideoCloud
  class Video
    require_relative 'api_base'

    def initialize(options = {}, params = {})
      @options = options
      @params = params
    end

    def videos
      ApiBase.new(@options, @params).exec_paging_api
    end

    def video
      ApiBase.new(@options, @params).exec_api
    end
  end
end
