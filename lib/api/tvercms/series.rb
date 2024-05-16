class Series
  require_relative 'tver_cms_auth'
  require_relative '../base'

  END_POINT = '/api/series'.freeze

  def exec_vod_series_api
    series_id = BASE.args[:id]
    if series_id
      vod_series_single(series_id)
    else
      vod_series_all
    end
  end

  private

  def vod_series_all
    tca = TverCmsAuth.new
    con = tca.craete_apiheaders_for_auth
    response = con.get(END_POINT) do |req|
      # requestパラメータ指定したければする
      req.params['']
    end
    result = JSON.pretty_generate(JSON.parse(response.body)['result'])
    BASE.output_json(Series.name, result)
  end

  def vod_series_single(vod_series_id)
    tca = TverCmsAuth.new
    con = tca.craete_apiheaders_for_auth
    response = con.get("#{END_POINT}/#{vod_series_id}") do |req|
      # requestパラメータ指定したければする
      req.params['']
    end
    puts response.body
    result = JSON.pretty_generate(JSON.parse(response.body)['result'])
    BASE.output_json(Series.name, result)
  end
end
