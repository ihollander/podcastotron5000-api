module ItunesAPI
  class ApiClient
    API_URL = "https://itunes.apple.com"

    def self.search(term)
      self.request(
        http_method: :get,
        endpoint: "/search",
        params: {
          media: "podcast",
          term: term
        }
      )
    end

    private

    def self.client
      Faraday.new(API_URL) do |client|
        client.request :url_encoded
        client.adapter Faraday.default_adapter
      end
    end

    def self.request(http_method:, endpoint:, params: {})
      Rails.logger.debug "iTunes request params: #{params}"
      response = self.client.public_send(http_method, endpoint, params)
      Oj.load(response.body)
    end

  end
end