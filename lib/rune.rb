require 'openssl'
require 'base64'

class Rune
  VERSION = Version = '0.1.1'

  attr_accessor :url
  attr_accessor :auth_token
  attr_accessor :params

  def initialize(url, auth_token, params = {})
    @url = url
    @auth_token = auth_token
    @params = params
  end
  
  # Generate the signature.
  # 
  # Returns the String signature.
  def generate
    data = flatten(stringify_keys(@params)).join
    digest = OpenSSL::Digest::Digest.new("sha1")
    Base64.encode64(OpenSSL::HMAC.digest(digest, @auth_token, "#{@url}#{data}")).strip
  end

  private

  # Stringify the keys of a Hash.
  # 
  # Returns the Hash that has strings for keys.
  def stringify_keys(hash)
    hash.keys.each do |key|
      hash[key.to_s] = hash.delete(key)
    end

    hash.values.select{ |v| v.is_a?(Hash) }.each do |h| 
      stringify_keys(h)
    end
    hash
  end
  
  # Recursively flatten the hash. Each level of the hash is sorted
  # alphabetically based on key name.
  #
  # Returns an Array of the hash, flattened. Mind fuck.
  def flatten(value)
    if value.is_a?(Array)
      value.flatten.map{ |v| flatten(v) }
    elsif value.is_a?(Hash)
      value.to_a.sort_by do |k| 
        k[0].to_s
      end.map { |v| flatten(v) }.flatten
    else
      value.to_s
    end
  end
end
