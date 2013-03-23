# EncryptoSigno

This is a little Ruby library which provides a simple interface for
encrypting & signing strings. Obviously, it also includes functions
to decrypt and verify signed objects.

## Usage

Using the EncryptoSigno library is easy and you can get started straight
away. Just install the gem `encrypto_signo` and you can use the methods
shown below.

### Keys

In order to use this, you will need to generate a keypair which will be
used to secure your information. Once you have generated the keys, you
can store them were ever but you should ensure you keep the private key
secure at all times. Avoid checking the private key into any source 
control you may be using.

#### The types of keys

* Anyone with your **public** key will be able to verify signed data or
encrypt data which you can then decrypt.

* If your **private** key was to be used by an un-authorised party, they
would be able to sign or decrypt data.

#### Generating keys

You can either use the OpenSSL command line tool or generate a key pair 
through the EncryptoSigno helper method. Both options are documented below:

```ruby
keypair     = EncryptoSigno.generate_keypair
private_key = keypair.to_s
public_key  = keypair.public_key.to_s
# You can store these as you feel is appropriate.
```

```bash
openssl genrsa -out path/to/private.key 2048
openssl rsa -pubout -in path/to/private.key -out path/to/public.key
```

### Encryption & Decrypting

If you are sending sensitive data over an insecure network connection, you
should encrypt it. When the data is received at the other end, it should be
decrypted. The example below outlines how to go about this:

```ruby
string = "This is a private string I would like to encrypt!"
encrypted_string = EncryptoSigno.encrypt(public_key, string)    #=> "imeic8XDDJ0hcTisZIkRUHj5xgUtohfgOYg38lX7c82rAgj1Mu1Qz7bTV29v\nK9D89wKVNaSqmzQHsjMxH360FVb8H0k7t0Q11QahLeDVzlpwb3UxyHz/aNBB\nQ3/ZoZ6P0p3dT61g7Ogb5/6JNVPerewUYngTVOG/pVC+zNAOJ0I=\n|z2h4I2PZLHqNq+FCF/9ryQ=="
decrypted_string = EncryptoSigno.decrypt(private_key, string)   #=> "This is a private string I would like to encrypt!"
```

### Signing & Verifying

If you would like to verify the authenticity of data you are receiving you
can sign it and send the signature along with the original data. You should
note that the original data is not encrypted when signing. It just verifies that
sent data was sent by someone/thing with your private key.

```ruby
string = "Bananas are tasty!"
signature = EncryptoSigno.sign(private_key, string)     #=> "ogolcwG8/+Mfk5Aor1sa+YiWQG4O9qkNqrMOQVEOCHz1YUuZCuQyAEW2lNHl\nTMoURYEYcTdzb08rPbo8uhIbhQvCTLgr6T9aK46VSwwtAH5z14baa2eCxcba\nDdgnFMLg62LE+cbAYJz2JyDb0Scn7jpWVZDhAZ7vO+V0qrQqKdA="
# Your string & signature should now be sent. In most cases, you will want to
# add a timestamp to signed requests to remove the possibility of replay attacks.
EncryptoSigno.verify(public_key, signature, string)     #=> true
```

