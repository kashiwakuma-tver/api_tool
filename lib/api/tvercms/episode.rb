class TverCMS
  class Episode
    require_relative 'api_base'

    def initialize(options = {}, params = {})
      @options = options
      @params = params
    end

    def episode_vods
      ApiBase.new(@options, @params).exec_paging_api
    end

    def episode_vod
      ApiBase.new(@options, @params).exec_api
    end

    def episode_lives
      ApiBase.new(@options, @params).exec_paging_api
    end

    def episode_live
      ApiBase.new(@options, @params).exec_api
    end
  end
end
