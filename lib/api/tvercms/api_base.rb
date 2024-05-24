class ApiBase
  require_relative 'auth'
  require_relative '../base'

  def initialize(args = {})
    @api_type = args[:api_type]
    @content_key = args[:content_key]
    @environment = args[:environment] || 'dev'
  end

  def exec_paging_api(params = {})
    con = api_auth_headers
    results = []
    offset = 0
    loop do
      puts "#{offset}件目からデータ取得中"
      response = con.get(end_point) do |req|
        req.params['offset'] = offset
        params&.each do |k, v|
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
    BASE.json_to_csv("#{filename}.csv", results_json) if results_json.empty?
  end

  def exec_api(params = nil)
    con = api_auth_headers
    response = con.get(end_point) do |req|
      params&.each do |k, v|
        req.params[k] = v
      end
    end
    result = JSON.pretty_generate(JSON.parse(response.body)['result'])
    BASE.output_json("#{filename}.json", result)
  end

  private

  def api_auth_headers
    tca = Auth.new
    tca.craete_apiheaders_for_auth
  end

  def end_point
    # end_points = YAML.load_file('endpoint.yaml')
    return "api/#{@api_type}/#{@content_key}" if @content_key.present?

    "api/#{@api_type}"
  end

  def filename
    "#{@environment}_#{end_point.gsub('api/', '').gsub('/', '_')}_#{Time.now.strftime('%Y%m%d%H%M%S')}"
  end
end
