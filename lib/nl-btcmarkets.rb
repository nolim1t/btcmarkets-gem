require 'base64'
require 'cgi'
require 'openssl'
require 'json'
require 'digest/md5'
require 'httparty'

class BTCMarkets
	include HTTParty
  base_uri 'https://api.btcmarkets.net'

  def initialize(options={})
		if ENV['btcm_access_secret'] and ENV['btcm_access_key'] then
			@apisecret = Base64.decode64(ENV['btcm_access_secret'])
			@apikey = ENV['btcm_access_key']
		else
			@apisecret = ''
			@apikey = ''
		end
		@nonce = (Time.now.to_f * 1000).to_i.to_s
    @parameters = ''
  end

  def method_missing(method_sym, *arguments, &block)
    convert_undercores_to_slashes = method_sym.to_s.gsub('_','/')
		method_type = convert_undercores_to_slashes.split('/')[0]
		convert_undercores_to_slashes = convert_undercores_to_slashes.gsub(method_type + '/','')
    if arguments.length == 1 then
      if arguments[0].kind_of? Hash
        @parameters = arguments[0].to_json # Its a json thing!
			end
    end
    @nonce = (Time.now.to_f * 1000).to_i.to_s # generate a new one each time
    if @parameters != ''
      to_sign = '/' + convert_undercores_to_slashes + "\n" + @nonce + "\n" + @parameters.to_s
    else
      to_sign = '/' + convert_undercores_to_slashes + "\n" + @nonce + "\n"
    end
		if @apisecret != '' and @apikey != '' then
			ssl_sign = OpenSSL::HMAC.digest('sha512', @apisecret, to_sign)
	    ssl_sign_encoded = Base64.encode64(ssl_sign).to_s.gsub("\n",'')
			if method_type == "get" then
	    	self.class.get('/' + convert_undercores_to_slashes, :headers => {'Accept-Charset' => 'UTF-8', 'Accept' => 'application/json','Content-Type' => 'application/json', 'apikey' => @apikey , 'signature' => ssl_sign_encoded, 'timestamp' => @nonce}).to_json
			else
				if method_type == "post" and @parameters != '' then
	    		self.class.post('/' + convert_undercores_to_slashes, :body => @parameters.to_s, :headers => {'Accept-Charset' => 'UTF-8', 'Accept' => 'application/json','Content-Type' => 'application/json', 'apikey' => @apikey , 'signature' => ssl_sign_encoded, 'timestamp' => @nonce}).to_json
				else
					# No parameters
					self.class.post('/' + convert_undercores_to_slashes, :headers => {'Accept-Charset' => 'UTF-8', 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'apikey' => @apikey , 'signature' => ssl_sign_encoded, 'timestamp' => @nonce}).to_json
				end
			end
		else
			"APISECRET and APIKEY not set"
		end
  end
end
