require 'encrypto_signo'

public_key    = File.read(File.join(File.dirname(__FILE__), 'public_key.pem'))
private_key    = File.read(File.join(File.dirname(__FILE__), 'private_key.pem'))

puts "Public Key......: #{public_key.size} bytes"
puts "Private Key.....: #{private_key.size} bytes"

raw_string    = "Hello World"

encrypted_string = EncryptoSigno.encrypt(public_key, raw_string)          #=> EncryptedString
decrypted_string = EncryptoSigno.decrypt(private_key, encrypted_string)   #=> "Hello World"

puts "Original String......: '#{raw_string}'"
puts "Encrypted String.....: '#{encrypted_string}'"
puts "Decrypted String.....: '#{decrypted_string}'"
