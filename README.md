Rune
===================

Rune was written to provide a simple authentication signature generator for APIs. Each user has a secret `auth_token` which they will use to sign a request before sending it. When the API receives the request, it performs the same process on the request data and compares the resulting signature to that the signature passed over the wire. If they match, it's an authorized request.

The signature is generated using the following algorithm:

* Alphabetize all POST fields
* Concatinate the key and value of each POST field to eachother, concatinate each 
  field name and value to the end of the URL
* Using the string containing the URL, query string and POST fields, sign them using HMAC-SHA1 and the auth_token as the key.

I suggest providing this signature to your API via an HTTP header like "X-YOUR_API_NAME-Signature".
