class Vod
  require_relative 'auth'
  require_relative '../base'
  require_relative 'api_base'

  KEY_BROADCAST_PROVIDER_IDS = %w[ntv abc ex ktv tver cx mbs tvo ytv tbs].freeze

  def initialize
    @args = { api_type: 'vod', content_key: '', environment: 'dev' }
  end

  def vod
    params = {}
    ApiBase.new(@args).results_exec_api(params)
  end
end
