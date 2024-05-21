class Vod
  require_relative 'auth'
  require_relative '../base'
  require_relative 'api_base'

  END_POINT = '/api/vod'.freeze

  KEY_BROADCAST_PROVIDER_IDS = %w[ntv abc ex ktv tver cx mbs tvo ytv tbs].freeze

  def self.vod
    api = ApiBase.new('vod')
    api.results_exec_api
  end
end
