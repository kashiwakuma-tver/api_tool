class ApiBase
  require_relative 'auth'
  require_relative '../base'

  def initialize(options = {}, params = {})
    @api_type = options[:api_type]
    @cookie = options[:cookie]
    @id = options[:id] || nil
    @offset = options[:offset] || 0
    @url = options[:url]
    @params = params
  end

  def exec_paging_api
    results = []
    offset = @offset
    loop do
      puts "#{offset}件目からデータ取得中"
      response = Faraday.new(url: @url).get(end_point) do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['cookie'] = "manager-tver=#{@cookie}"
        req.params['offset'] = offset
        @params&.each do |k, v|
          req.params[k] = v
        end
      end
      results << JSON.parse(response.body)['result']
      total = JSON.parse(response.body)['paging']['total']
      offset = JSON.parse(response.body)['paging']['offset']
      break if total <= offset
    end
    JSON.pretty_generate(results)
  end

  def exec_api
    response = Faraday.new(url: @url).get(end_point) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['cookie'] = "manager-tver=#{@cookie}"
      @params&.each do |k, v|
        req.params[k] = v
      end
    end
    JSON.parse(response.body)
  end

  private

  def end_point
    return "api/#{@api_type}/#{@id}" if @id.present?

    "api/#{@api_type}"
  end

  # 一旦コメントアウトします
  # def filename
  #   "#{@environment}_#{end_point.gsub('api/', '').gsub('/', '_')}_#{Time.now.strftime('%Y%m%d%H%M%S')}"
  # end
end
