import 'package:corsac_jwt/corsac_jwt.dart';

class ManageAccessToken
{
  static JWT __jwt;
  static String __value;

  static String get value => __value;


  static void parse(String accessToken)
  {
    __value = accessToken;
    __jwt = new JWT.parse(__value);

    //__jwt.claims['userId'];
  }



  static void test() async
  {
    /*
    var builder = new JWTBuilder();
    var token = builder
      ..issuer = 'https://api.foobar.com'
      ..expiresAt = new DateTime.now().add(new Duration(minutes: 3))
      ..setClaim('data', {'userId': 836})
      ..getToken(); // returns token without signature

    var signer = new JWTHmacSha256Signer('sharedSecret');
    var signedToken = builder.getSignedToken(signer);
    print(signedToken); // prints encoded JWT
    var stringToken = signedToken.toString();
    */

    JWTHmacSha256Signer signer = new JWTHmacSha256Signer('MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgFdWxe1+mSWMojsDjNpurrY20ZT6ZhuKKubjP+Pf1u5qgCgYIKoZIzj0DAQehRANCAASQrzJWzKzEfx7EKk9ZWgL6YShELIDH175JK75WXAmcsm8V6hQedvLNLeU8e3SblnplnetZyM9+Sg11Ug8dL+CH');

    JWT decodedToken = new JWT.parse('eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjM2RkxLODRUWkYifQ.eyJpYXQiOjE1NjYxOTI3MzYsImV4cCI6MTYyODQwMDc5NiwiaXNzIjoiWlo3Mk5DSjk0WSIsInVzZXJJZCI6IjExMzMifQ.iykzj3ML-JNXDQsx9Jw9ITbkMWEMlVDZw37JDOPcemGnQkF5pXfc-Zb5_FySdbkyet4zUuIUw0k7796KfDW3jQ');

    print('userId : ${decodedToken.claims['userId']}');

    // Verify signature:
    print('DecodedTokenVerify :  ${decodedToken.verify(signer)}'); // true

    /*
    // Validate claims:
    var validator = new JWTValidator() // uses DateTime.now() by default
      ..issuer = 'https://api.foobar.com'; // set claims you wish to validate
    Set<String> errors = validator.validate(decodedToken);
    print(errors); // (empty list)
    */
  }


}