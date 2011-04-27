require 'openssl'
require 'base64'

class Rune
  VERSION = Version = '0.1'

  attr_accessor :url
  attr_accessor :auth_token
  attr_accessor :params

  def initialize(url, auth_token, params = {})
    @url = url
    @auth_token = auth_token
    @params = params
  end
  
  # Generate the signature
  # 
  # Returns the String signature
  def generate
    data = recursive_flatten(recursive_stringify_keys(@params)).to_a.sort_by{|k| k[0].to_s}.flatten.join
    digest = OpenSSL::Digest::Digest.new("sha1")
    Base64.encode64(OpenSSL::HMAC.digest(digest, @auth_token, "#{@url}#{data}")).strip
  end

  private

  # Stringify the keys of a Hash
  # 
  # Returns the Hash that has strings for keys
  def stringify_keys(hash)
    hash.keys.each do |key|
      hash[key.to_s] = hash.delete(key)
    end
    hash
  end

  # Recursively apply stringify_keys to a Hash
  # 
  # Returns the Hash that has strings for keys
  def recursive_stringify_keys(hash)
    hash = stringify_keys(hash)
    hash.values.select{ |v| v.is_a?(Hash) }.each do |h| 
      recursive_stringify_keys(h)
    end
    hash
  end
  
  # Recursively flatten the hash
  #
  # Returns an Array of the hash sorted alphabetically. Mind fuck.
  def recursive_flatten(hash)
    (recursive = lambda do |v|
      if v.is_a?(Array)
        v.flatten.map{ |v| recursive.call(v) }
      elsif v.is_a?(Hash)
        v.to_a.sort_by{|k| k[0].to_s}.map { |v| recursive.call(v) }.flatten
      else
        v.to_s
      end
    end).call(hash)
  end
end
