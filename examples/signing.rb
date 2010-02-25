require 'basic_ssl'

public_key    = File.read(File.join(File.dirname(__FILE__), 'public_key.pem'))
private_key    = File.read(File.join(File.dirname(__FILE__), 'private_key.pem'))

puts "Public Key......: #{public_key.size} bytes"
puts "Private Key.....: #{private_key.size} bytes"

raw_string    = "Hello World"

signature = BasicSSL.sign(private_key, raw_string)        #=> EncryptedString
if BasicSSL.verify(public_key, signature, raw_string)
  puts "Signature was verified"
else
  puts "Signature was not verified"
end
