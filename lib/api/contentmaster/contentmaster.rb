class ContentMaster
  require_relative '../base'

  END_POINT = { series: 'series', season: 'season', episode: 'episode/vod' }.freeze

  def initialize(args = {})
    @environment = args[:environment] || 'dev'
    @provider_id = args[:provider] || 'cx'
    @api_type = args[:api_type] || 'series'
    @time = args[:time] || Time.now
    @content_key = args[:content_key] || nil
  end

  def results_exec_api
    url, token = url_and_token(@environment, @provider_id)
    connection = Faraday.new(url:) do |con|
      con.use FaradayMiddleware::FollowRedirects
      con.adapter :net_http
    end

    response = connection.get(end_point) do |req|
      req.headers['X-TVER-CONTENTS-MASTER-SECRET'] = token
      req.params['target'] = 1713315300
    end
    result = JSON.pretty_generate(JSON.parse(response.body))
    BASE.output_json("#{@environment}_#{@provider_id}_#{@api_type}_#{Time.now.strftime('%Y%m%d%H%M%S')}.json", result)
  end

  private

  def end_point
    return "api/v1/#{END_POINT[@api_type.to_sym]}/#{@content_key}" if @content_key.present?

    "api/v1/#{END_POINT[@api_type.to_sym]}"
  end

  def url_and_token(environment, broadcast_id)
    yaml = YAML.load_file('meta_url.yaml')
    [
      yaml[environment.to_sym][broadcast_id.to_sym][:url],
      yaml[environment.to_sym][broadcast_id.to_sym][:token]
    ]
  end
end
