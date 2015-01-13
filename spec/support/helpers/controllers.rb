module Helpers
  module Controllers
    def mock_authentication_with(api_key)
      request.env['HTTP_AUTHORIZATION'] = "Token token=#{api_key.access_token}"
    end
  end
end
