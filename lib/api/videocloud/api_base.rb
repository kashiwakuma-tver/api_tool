class VideoCloud
  class ApiBase
    require_relative 'create_token'
    require_relative '../../../library'

    def initialize(options = {}, params = {})
      @api_type = options[:api_type]
      @token = options[:token]
      @account_id = options[:account_id]
      @video_id = options[:video_id] || nil
      @url = options[:url]
      @params = params
    end

    def exec_paging_api
      results = []
      total = total_videos
      init_offset = @params[:offset]
      offset = @params[:offset]
      loop do
        puts "#{offset}件目からデータ取得中"
        response = api_get
        results << JSON.parse(response.body)
        offset += init_offset
        break if total <= offset
      end
      results
    end

    def exec_api
      response = api_get
      JSON.parse(response.body)
    end

    private

    def total_videos
      puts @url
      response = Faraday.new(url: @url).get("#{@account_id}/counts/videos") do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = "Bearer #{@token}"
        @params&.each do |k, v|
          req.params[k] = v
        end
      end
      JSON.parse(response.body)['count']
    end

    def api_get
      Faraday.new(url: @url).get(end_point) do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = "Bearer #{@token}"
        @params&.each do |k, v|
          req.params[k] = v
        end
      end
    end

    def end_point
      case @api_type
      when 'ingest_jobs'
        "#{@account_id}/videos/#{@video_id}/ingest_jobs"
      when 'videos'
        "#{@account_id}/#{@api_type}"
      end
    end
  end
end
