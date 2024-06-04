class Vod
  require_relative 'api_base'

  KEY_BROADCAST_PROVIDER_IDS = %w[ntv abc ex ktv tver cx mbs tvo ytv tbs].freeze

  def initialize(options = {}, params = {})
    @options = options
    @params = params
  end

  def vod
    ApiBase.new(@options, @params).exec_api
  end
end
