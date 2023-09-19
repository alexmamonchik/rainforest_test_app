# require 'uri'
# require 'net/http'
require 'httparty'

class Rainforest
  def initialize(url, format = :json)
    @uri = URI(url)
    @options = { format: format }
    @uri.query = URI.encode_www_form(@options)
  end

  def challenge
    resp = get_chunk
    return resp if resp.is_a?(String)

    if resp['follow']
      code = extract_code(resp['follow'])
      @uri.query = URI.encode_www_form(@options.merge(id: code))

      puts "Another call with id: #{code}"

      challenge
    else
      puts resp['message']
      resp['message']
    end
  end

  private

  def get_chunk
    res = HTTParty.get(@uri, @options)
    res.parsed_response
  end

  def extract_code(url)
    code_match = url.match(/id=(\d+)$/)
    code_match[1] if code_match.is_a?(MatchData)
  end
end