class ApiBase
  require_relative 'auth'
  require_relative '../base'

  def initialize(api_name, id = nil)
    @api_name = api_name
    @id = id
  end

  def results_of_paging_api
    con = api_auth_headers
    results = []
    offset = 100
    loop do
      response = con.get(end_point) do |req|
        # requestパラメータ指定したければする
        req.params['offset'] = offset
      end
      results << JSON.parse(response.body)['result']
      total = JSON.parse(response.body)['paging']['total']
      offset = JSON.parse(response.body)['paging']['offset']
      puts "#{offset - 100}~#{offset}を取得"
      break if total <= offset
    end
    BASE.output_json(@api_name, JSON.pretty_generate(results))
  end

  def result_of_single_api
    puts 'idが指定されていません' if @id.nil?
    con = api_auth_headers
    response = con.get("#{end_point}/#{@id}") do |req|
      # requestパラメータ指定したければする
      # req.params['hoge'] = 'fuga'
    end
    result = JSON.pretty_generate(JSON.parse(response.body)['result'])
    BASE.output_json("#{@api_name}_single", result)
  end

  private

  def end_point
    end_points = YAML.load_file('endpoint.yaml')
    "api/#{end_points[@api_name.to_sym]}"
  end

  def api_auth_headers
    tca = Auth.new
    tca.craete_apiheaders_for_auth
  end
end
