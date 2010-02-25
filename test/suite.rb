require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'basic_ssl'

class BasicSSLTest < Test::Unit::TestCase
  
  context "Basic SSL" do
    setup do
      @public_key    = File.read(File.join(File.dirname(__FILE__), '../examples/public_key.pem'))
      @private_key   = File.read(File.join(File.dirname(__FILE__), '../examples/private_key.pem'))
    end
  
    should "should encrypt & decrypt a string when passed valid keys" do
      encrypted_string = BasicSSL.encrypt(@public_key, 'hello world!')
      assert encrypted_string.is_a?(String)
      decrypted_string = BasicSSL.decrypt(@private_key, encrypted_string)
      assert_equal 'hello world!', decrypted_string
    end
    
    should "should sign & verify a string" do
      raw_string = "testing 123456. kthxbai!"
      signature = BasicSSL.sign(@private_key, raw_string)
      assert signature.is_a?(String)
      assert BasicSSL.verify(@public_key, signature, raw_string)
    end
    
    should "encrypt & decrypt a large string" do
      raw_string = "A" * 4096
      signature = BasicSSL.sign(@private_key, raw_string)
      assert signature.is_a?(String)
      assert BasicSSL.verify(@public_key, signature, raw_string)
    end
    
  end
  
end
