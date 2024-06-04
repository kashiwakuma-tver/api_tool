class ApiBase
  require_relative 'auth'
  require_relative '../base'

  def initialize(options = {}, params = {})
    @api_type = options[:api_type]
    @content_key = options[:content_key]
    @environment = options[:environment]
    @need_csv = options[:need_csv]
    @params = params
  end

  def exec_paging_api
    con = api_auth_headers
    results = []
    offset = 0
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
    results_json = JSON.pretty_generate(results)
    BASE.output_json("#{filename}.json", results_json)
    BASE.json_to_csv("#{filename}.csv", results_json) if @need_csv
  end

  def exec_api
    con = api_auth_headers
    response = con.get(end_point) do |req|
      @params&.each do |k, v|
        req.params[k] = v
      end
    end
    result = JSON.pretty_generate(JSON.parse(response.body)['result'])
    BASE.output_json("#{filename}.json", result)
  end

  private

  def api_auth_headers
    tca = Auth.new(@environment)
    tca.craete_apiheaders_for_auth
  end

  def end_point
    return "api/#{@api_type}/#{@content_key}" if @content_key.present?

    "api/#{@api_type}"
  end

  def filename
    "#{@environment}_#{end_point.gsub('api/', '').gsub('/', '_')}_#{Time.now.strftime('%Y%m%d%H%M%S')}"
  end
end
