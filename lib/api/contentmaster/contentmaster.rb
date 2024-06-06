class ContentMaster
  def initialize(options = {}, params = {})
    @url = options[:url]
    @token = options[:token]
    @api_type = options[:api_type]
    @id = options[:id]
    @params = params
  end

  def exec_api
    connection = Faraday.new(url: @url) do |con|
      con.use(FaradayMiddleware::FollowRedirects)
      con.adapter(:net_http)
    end

    response = connection.get(end_point) do |req|
      req.headers['X-TVER-CONTENTS-MASTER-SECRET'] = @token
      @params&.each do |k, v|
        req.params[k] = v
      end
    end
    JSON.parse(response.body)
  end

  private

  def end_point
    return "/api/v1/#{@api_type}/#{@id}" if @id.present?

    "/api/v1/#{@api_type}"
  end

  # 一旦コメントアウトします
  # def filename
  #   "#{@environment}_#{end_point.gsub('api/', '').gsub('/', '_')}_#{@broadcast_provider_id}_#{Time.now.strftime('%Y%m%d%H%M%S')}"
  # end
end
