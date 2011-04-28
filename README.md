# Rune

Rune was written to provide a simple authentication signature generator for APIs. 

Imagine you have a super-awesome API. Each user of your API has a secret `auth_token` which they will use to sign requests before sending them to you. When the API receives these requests, it performs the same process on the request ata and compares the resulting signature to the signature that was given by the client. If they match—huzzah!—they have entry.

The signature is generated using the following algorithm:

* Alphabetize all POST fields
* Concatinate the key and value of each POST field to eachother, concatinate each 
  field name and value to the end of the URL
* Using the string containing the URL, query string and POST fields, sign them using HMAC-SHA1 and the auth_token as the key.

*I suggest providing this signature to your API via an HTTP header like "X-YOUR_API_NAME-Signature".*

## Example Usage

``` ruby
rune = Rune.new(
  'http://localhost/people',
  'super_secret_auth_token',
  {:person => {:name  => "Name", :age => "29"}, :other => "dude"}
)

rune.generate #=> "BVuqfY28b69Bnt2Kiaj2CObOec0="
```
