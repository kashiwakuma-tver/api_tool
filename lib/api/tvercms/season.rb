class TverCMS
  class Season
    require_relative 'api_base'

    def initialize(options = {}, params = {})
      @options = options
      @params = params
    end

    def series_seasons
      ApiBase.new(@options, @params).exec_api
    end

    def series_season
      ApiBase.new(@options, @params).exec_api
    end

    def season
      ApiBase.new(@options, @params).exec_api
    end
  end
end
