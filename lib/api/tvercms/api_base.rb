class ApiBase
  require_relative 'auth'
  require_relative '../base'

  def initialize(options = {}, params = {})
    @api_type = options[:api_type]
    @id = options[:id]
    @environment = options[:environment]
    @need_csv = options[:need_csv]
    @params = params
  end

  def exec_paging_api
    con = api_auth_headers
    results = []
    offset = 9000
    loop do
      puts "#{offset}件目からデータ取得中"
      response = con.get(end_point) do |req|
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
    con = api_auth_headers
    response = con.get(end_point) do |req|
      @params&.each do |k, v|
        req.params[k] = v
      end
    end
    JSON.parse(response.body)
  end

  private

  def api_auth_headers
    tca = Auth.new(@environment)
    tca.craete_apiheaders_for_auth
  end

  def end_point
    return "api/#{@api_type}/#{@id}" if @id.present?

    "api/#{@api_type}"
  end

  # 一旦コメントアウトします
  # def filename
  #   "#{@environment}_#{end_point.gsub('api/', '').gsub('/', '_')}_#{Time.now.strftime('%Y%m%d%H%M%S')}"
  # end
end
