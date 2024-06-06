class ApiBase
  require_relative 'create_token'
  require_relative '../../../library'

  def initialize(options = {}, params = {})
    @api_type = options[:api_type]
    @token = options[:token]
    @account_id = options[:account_id]
    @id = options[:id] || nil
    @url = options[:url]
    @params = params
  end

  def exec_paging_api
    results = []
    loop do
      puts "#{@params[:offset]}件目からデータ取得中"
      response = api_get
      puts response.body
      # results << JSON.parse(response.body)['result']
      # total = JSON.parse(response.body)['paging']['total']
      # @params[:offset] = JSON.parse(response.body)['paging']['offset']
      # break if total <= @params[:offset]
    end
    JSON.pretty_generate(results)
  end

  def exec_api
    response = api_get
    JSON.parse(response.body)
  end

  private

  def api_get
    puts @url
    puts end_point
    Faraday.new(url: @url).get(end_point) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{@token}"
      @params&.each do |k, v|
        req.params[k] = v
      end
    end
  end

  def end_point
    return "#{@account_id}/#{@api_type}/#{@id}" if @id.present?

    "#{@account_id}/#{@api_type}"
  end
end
