class TverCMS
  class ApiBase
    require_relative 'auth'
    require_relative '../../../library'

    def initialize(options = {}, params = {})
      @api_type = options[:api_type]
      @cookie = options[:cookie]
      @id = options[:id] || nil
      @url = options[:url]
      @params = params
    end

    def exec_paging_api
      results = []
      loop do
        puts "#{@params[:offset]}件目からデータ取得中"
        response = api_get
        results << JSON.parse(response.body)['result']
        total = JSON.parse(response.body)['paging']['total']
        @params[:offset] = JSON.parse(response.body)['paging']['offset']
        break if total <= @params[:offset]
      end
      results
    end

    def exec_api
      response = api_get
      JSON.parse(response.body)
    end

    private

    def api_get
      Faraday.new(url: @url).get(end_point) do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['cookie'] = "manager-tver=#{@cookie}"
        @params&.each do |k, v|
          req.params[k] = v
        end
      end
    end

    def end_point
      return "api/#{@api_type}/#{@id}" if @id.present?

      "api/#{@api_type}"
    end
  end
end
