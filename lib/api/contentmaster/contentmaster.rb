class ContentMaster
  require_relative '../base'

  END_POINT = { series: 'series', season: 'season', episode: 'episode/vod' }.freeze

  def initialize(option = {}, params = {})
    @environment = option[:environment]
    @broadcast_provider_id = option[:broadcast_provider_id]
    @api_type = option[:api_type]
    @content_key = option[:content_key]
    @params = params
  end

  def exec_api
    url, token = url_and_token
    connection = Faraday.new(url:) do |con|
      con.use FaradayMiddleware::FollowRedirects
      con.adapter :net_http
    end

    response = connection.get(end_point) do |req|
      req.headers['X-TVER-CONTENTS-MASTER-SECRET'] = token
      @params&.each do |k, v|
        req.params[k] = v
      end
    end
    result = JSON.pretty_generate(JSON.parse(response.body))
    BASE.output_json("#{filename}.json", result)
  end

  private

  def end_point
    return "api/v1/#{END_POINT[@api_type.to_sym]}/#{@content_key}" if @content_key.present?

    "api/v1/#{END_POINT[@api_type.to_sym]}"
  end

  def url_and_token
    yaml = YAML.load_file('meta_url.yaml')
    [
      yaml[@environment.to_sym][@broadcast_provider_id.to_sym][:url],
      yaml[@environment.to_sym][@broadcast_provider_id.to_sym][:token]
    ]
  end

  def filename
    "#{@environment}_#{end_point.gsub('api/', '').gsub('/', '_')}_#{@broadcast_provider_id}_#{Time.now.strftime('%Y%m%d%H%M%S')}"
  end
end
