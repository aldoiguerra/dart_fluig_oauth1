library credentials;

import 'dart:convert';

/// A class describing OAuth credentials except for client credential
class Credentials {
  final String? _token;
  final String? _tokenSecret;
  final int? _timestamp_gerate;

  Credentials(this._token, this._tokenSecret, this._timestamp_gerate);

  factory Credentials.fromMap(Map<String, String> parameters) {
    if (!parameters.containsKey('oauth_token')) {
      throw ArgumentError("params doesn't have a key 'oauth_token'");
    }
    if (!parameters.containsKey('oauth_token_secret')) {
      throw ArgumentError("params doesn't have a key 'oauth_token_secret'");
    }
    return Credentials(parameters['oauth_token'], parameters['oauth_token_secret'], DateTime.now().millisecondsSinceEpoch);
  }

  factory Credentials.fromJSON(String jstr) {
    return Credentials.fromMap(json.decode(jstr));
  }

  String? get token => _token;
  String? get tokenSecret => _tokenSecret;
  int? get timestamp_gerate => _timestamp_gerate;

  @override
  String toString() {
    return 'oauth_token=$token&oauth_token_secret=$tokenSecret';
  }

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{'oauth_token': token, 'oauth_token_secret': tokenSecret};
  }
}
