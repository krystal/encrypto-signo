require 'openssl'
require 'base64'

module BasicSSL
  
  class << self

    ## Returns an Base64 encoded string with encryption
    def encrypt(key, string)
      aes_encrypt = OpenSSL::Cipher::Cipher.new('AES-256-CBC').encrypt
      aes_encrypt.key = aes_key = aes_encrypt.random_key
      crypt = aes_encrypt.update(string) << aes_encrypt.final
      encrypted_key = rsa_key(key).public_encrypt(aes_key)
      [Base64.encode64(encrypted_key), Base64.encode64(crypt)].join("|")
    end
    
    ## Return the raw string after decryption & decoding
    def decrypt(key, string)
      encrypted_key, crypt = string.split("|").map{|a| Base64.decode64(a) }
      aes_key = rsa_key(key).private_decrypt(encrypted_key)
      aes_decrypt = OpenSSL::Cipher::Cipher.new('AES-256-CBC').decrypt
      aes_decrypt.key = aes_key
      aes_decrypt.update(crypt) << aes_decrypt.final
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
