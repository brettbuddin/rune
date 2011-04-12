Rune
===================

Generates an signature based on the following algorithm:

* Alphabetize all POST fields
* Concatinate the key and value of each POST field to eachother, concatinate each 
  field name and value to the end of the URL
* Using the string containing the URL, query string and POST fields, sign them using HMAC-SHA1 and the auth_token as the key.

I suggest providing this signature to your API via an HTTP header like "X-YOUR_API_NAME-Signature".
