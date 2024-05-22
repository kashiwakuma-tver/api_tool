class ApiBase
  require_relative 'auth'
  require_relative '../base'

  def initialize(api_name, id = nil)
    @api_name = api_name
    @id = id
  end

  def results_exec_paging_api(params = nil)
    con = api_auth_headers
    results = []
    offset = 0
    loop do
      puts "#{offset}件目からデータ取得中"
      response = con.get(end_point) do |req|
        req.params['offset'] = offset
        params.each do |k, v|
          req.params[k] = v
        end
      end
      results << JSON.parse(response.body)['result']
      total = JSON.parse(response.body)['paging']['total']
      offset = JSON.parse(response.body)['paging']['offset']
      break if total <= offset
    end
    BASE.output_json("#{@api_name}_paging", JSON.pretty_generate(results))
  end

  def results_exec_api
    con = api_auth_headers
    puts end_point
    response = con.get(end_point) do |req|
      api_params.each do |k, v|
        req.params[k] = v
      end
    end
    result = JSON.pretty_generate(JSON.parse(response.body)['result'])
    BASE.output_json(@api_name, result)
  end

  private

  def end_point
    end_points = YAML.load_file('endpoint.yaml')
    return "api/#{end_points[@api_name.to_sym]}/#{@id}" unless @id.nil?

    "api/#{end_points[@api_name.to_sym]}"
  end

  def api_auth_headers
    tca = Auth.new
    tca.craete_apiheaders_for_auth
  end
end
