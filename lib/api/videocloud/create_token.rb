class VideoCloud
  class CreateToken
    require_relative '../../../library'

    def exec
      access_token
    end

    private

    def access_token
      client_id = ENV['VIDEO_CLOUD_CLIENT_ID']
      client_secret = ENV['VIDEO_CLOUD_CLIENT_SECRET']
      basic_token = Base64.strict_encode64("#{client_id}:#{client_secret}")
      url = 'https://oauth.brightcove.com'

      con = Faraday.new(url:) do |c|
        c.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        c.headers['Authorization'] = "Basic #{basic_token}"
      end

      response = con.post('/v4/access_token') do |req|
        req.params['grant_type'] = 'client_credentials'
      end
      JSON.parse(response.body)['access_token']
    end
  end
end
