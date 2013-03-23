require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'encrypto_signo'

class EncryptoSignoTest < Test::Unit::TestCase
  
  context "EncryptoSigno" do
    setup do
      @public_key    = File.read(File.join(File.dirname(__FILE__), '../examples/public_key.pem'))
      @private_key   = File.read(File.join(File.dirname(__FILE__), '../examples/private_key.pem'))
    end
  
    should "should encrypt & decrypt a string when passed valid keys" do
      encrypted_string = EncryptoSigno.encrypt(@public_key, 'hello world!')
      assert encrypted_string.is_a?(String)
      decrypted_string = EncryptoSigno.decrypt(@private_key, encrypted_string)
      assert_equal 'hello world!', decrypted_string
    end
    
    should "should sign & verify a string" do
      raw_string = "testing 123456. kthxbai!"
      signature = EncryptoSigno.sign(@private_key, raw_string)
      assert signature.is_a?(String)
      assert EncryptoSigno.verify(@public_key, signature, raw_string)
    end
    
    should "encrypt & decrypt a large string" do
      raw_string = "A" * 4096
      encrypted_string = EncryptoSigno.encrypt(@public_key, raw_string)
      assert_equal raw_string, EncryptoSigno.decrypt(@private_key, encrypted_string)
    end
    
  end
  
end
