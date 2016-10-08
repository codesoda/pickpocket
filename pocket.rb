require 'json'
require 'rest-client'

class Pocket

  def initialize(consumer_key, access_token = nil)
    @consumer_key = consumer_key
    @access_token = access_token
  end

  def delete_all(ids)
    actions = []
    ids.each do |id|
      actions << { action: 'delete', item_id: id }
    end

    post('https://getpocket.com/v3/send', actions: actions)
  end

  def find_all(options = {})
    get('https://getpocket.com/v3/get', options)['list'] || []
  end

  def oauth_authorize(code)
    response = RestClient.post(
      'https://getpocket.com/v3/oauth/authorize',
      {
        consumer_key: ENV['POCKET_CONSUMER_KEY'],
        code: code
      }
    )
    response.body.split('&').first.split('=').last
  end

  def oauth_request(redirect_uri)
    response = RestClient.post(
      'https://getpocket.com/v3/oauth/request',
      credentials.merge(redirect_uri: redirect_uri)
    )
    response.body.split('=').last
  end

  private

  def credentials
    {
      consumer_key: @consumer_key,
      access_token: @access_token
    }
  end

  def get(url, params)
    response = RestClient.get(
      url,
      { params: credentials.merge(params) }
    )
    JSON.parse(response.body)
  end

  def post(url, params)
    response = RestClient.post(
      url,
      credentials.merge(params).to_json,
      content_type: :json
    )
    JSON.parse(response.body)
  end
end

#     RestClient.post(
#       'https://getpocket.com/v3/send',
#       {
#         consumer_key: ENV['POCKET_CONSUMER_KEY'],
#         access_token: ENV['POCKET_ACCESS_TOKEN'],
#         actions: actions
#       }.to_json,
#       content_type: :json
#     )

#     response = RestClient.get(
#       'https://getpocket.com/v3/get',
#       {
#         params: {
#           consumer_key: ENV['POCKET_CONSUMER_KEY'],
#           access_token: ENV['POCKET_ACCESS_TOKEN']
#         }.merge(options)
#       }
#     )
