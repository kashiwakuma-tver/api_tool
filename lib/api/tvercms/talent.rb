class TverCMS
  class Talent
    require_relative 'api_base'

    def initialize(options = {}, params = {})
      @options = options
      @params = params
    end

    def talents
      ApiBase.new(@options, @params).exec_paging_api
    end

    def talent
      ApiBase.new(@options, @params).exec_api
    end
  end
end
