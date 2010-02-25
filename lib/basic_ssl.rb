require 'openssl'
require 'base64'

module BasicSSL
  
  class << self
    
    ## Returns an Base64 encoded string with encryption
    def encrypt(key, string)
      Base64.encode64(rsa_key(key).public_encrypt(string))
    end
    
    ## Return the raw string after decryption & decoding
    def decrypt(key, string)
      rsa_key(key).private_decrypt(Base64.decode64(string))
    end
    
    ## Return a signature for the string
    def sign(key, string)
      Base64.encode64(rsa_key(key).sign(OpenSSL::Digest::SHA1.new, string))
    end
    
    ## Verify the string and signature
    def verify(key, signature, string)
      rsa_key(key).verify(OpenSSL::Digest::SHA1.new, Base64.decode64(signature), string)
    end
    
    private
    
    def rsa_key(key)
      OpenSSL::PKey::RSA.new(key)
    end
    
  end
  
end
