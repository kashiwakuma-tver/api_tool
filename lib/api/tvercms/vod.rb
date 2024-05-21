class Vod
  require_relative 'auth'
  require_relative '../base'

  END_POINT = '/api/vod'.freeze

  KEY_BROADCAST_PROVIDER_IDS = %w[ntv abc ex ktv tver cx mbs tvo ytv tbs].freeze
  def exec_vod_api
    vod_id = BASE.args[:id]
    if vod_id
      vod_single(vod_id)
    else
      vod_all
    end
  end

  def exec_vod_api_for_key_broadcast
    vod_key_broadcast
  end

  private

  def vod_all
    tca = Auth.new
    con = tca.craete_apiheaders_for_auth
    response = con.get(END_POINT) do |req|
      # requestパラメータ指定したければする
      req.params['']
    end
    result = JSON.pretty_generate(JSON.parse(response.body)['result'])
    BASE.output_json(Vod.name, result)
  end

  def vod_key_broadcast
    tca = Auth.new
    con = tca.craete_apiheaders_for_auth
    KEY_BROADCAST_PROVIDER_IDS.each do |id|
      response = con.get("#{END_POINT}/#{id}") do |req|
        # requestパラメータ指定したければする
        req.params['']
      end
      result = JSON.parse(response.body)['result']
    end
    # resultをjsonファイルに吐き出す
  end

  def vod_single(vod_id)
    tca = Auth.new
    con = tca.craete_apiheaders_for_auth
    response = con.get("#{END_POINT}/#{vod_id}") do |req|
      # requestパラメータ指定したければする
      req.params['']
    end
    result = JSON.pretty_generate(JSON.parse(response.body)['result'])
    BASE.output_json(Vod.name, result)
  end
end
