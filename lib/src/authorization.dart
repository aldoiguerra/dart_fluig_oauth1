library authorization;

import 'dart:async';
import 'package:http/http.dart' as http;

import 'credentials.dart';
import 'client_credentials.dart';
import 'platform.dart';
import 'authorization_header_builder.dart';
import 'authorization_response.dart';

/// A proxy class describing OAuth 1.0 redirection-based authorization.
/// http://tools.ietf.org/html/rfc5849#section-2
///
/// Redirection works are responded to client.
/// So you can do PIN-based authorization too if you want.
class Authorization {
  final ClientCredentials _clientCredentials;
  final Platform _platform;
  final http.BaseClient _httpClient;

  /// A constructor of Authorization.
  ///
  /// If you want to use in web browser, pass http.BrowserClient object for httpClient.
  /// https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/http/http-browser_client.BrowserClient
  Authorization(this._clientCredentials, this._platform, [http.BaseClient httpClient]) : _httpClient = httpClient != null ? httpClient : http.Client();

  /// Obtain a set of temporary credentials from the server.
  /// http://tools.ietf.org/html/rfc5849#section-2.1
  ///
  /// If not callbackURI passed, authentication becomes PIN-based.
  Future<AuthorizationResponse> requestTemporaryCredentials([String callbackURI]) async {
    callbackURI ??= 'oob';
    final Map<String, String> additionalParams = <String, String>{'oauth_callback': callbackURI};
    final AuthorizationHeaderBuilder ahb = AuthorizationHeaderBuilder();
    ahb.signatureMethod = _platform.signatureMethod;
    ahb.clientCredentials = _clientCredentials;
    ahb.method = 'POST';
    ahb.url = _platform.temporaryCredentialsRequestURI;
    ahb.additionalParameters = additionalParams;

//    print("Requisitanto token to: "+_platform.temporaryCredentialsRequestURI);
//    print("Authorization: "+ahb.build().toString());

    Uri temporaryCredentialsRequestURI = Uri.parse(_platform.temporaryCredentialsRequestURI);

    final http.Response res = await _httpClient.post(temporaryCredentialsRequestURI, headers: <String, String>{'Authorization': ahb.build().toString()});

//    print('Resposta statusCode: '+res.statusCode.toString());
//    print("Resposta body: "+res.body);

    if (res.statusCode != 200) {
      throw StateError(res.body);
    }

    final Map<String, String> params = Uri.splitQueryString(res.body);

    return AuthorizationResponse.fromMap(params);
  }

  /// Get resource owner authorization URI.
  /// http://tools.ietf.org/html/rfc5849#section-2.2
  String getResourceOwnerAuthorizationURI(String temporaryCredentialsIdentifier) {
    return _platform.resourceOwnerAuthorizationURI + '?oauth_token=' + Uri.encodeComponent(temporaryCredentialsIdentifier);
  }

  /// Obtain a set of token credentials from the server.
  /// http://tools.ietf.org/html/rfc5849#section-2.3
  Future<AuthorizationResponse> requestTokenCredentials(Credentials tokenCredentials, String verifier) async {
    final Map<String, String> additionalParams = <String, String>{'oauth_verifier': verifier};
    final AuthorizationHeaderBuilder ahb = AuthorizationHeaderBuilder();
    ahb.signatureMethod = _platform.signatureMethod;
    ahb.clientCredentials = _clientCredentials;
    ahb.credentials = tokenCredentials;
    ahb.method = 'POST';
    ahb.url = _platform.tokenCredentialsRequestURI;
    ahb.additionalParameters = additionalParams;

//    print("Requisitanto token to: "+_platform.tokenCredentialsRequestURI);
//    print("Authorization: "+ahb.build().toString());

    Uri tokenCredentialsRequestURI = Uri.parse(_platform.tokenCredentialsRequestURI);

    final http.Response res = await _httpClient.post(tokenCredentialsRequestURI, headers: <String, String>{'Authorization': ahb.build().toString()});

//    print('Resposta statusCode: '+res.statusCode.toString());
//    print("Resposta body: "+res.body);

    if (res.statusCode != 200) {
      throw StateError(res.body);
    }
    final Map<String, String> params = Uri.splitQueryString(res.body);
    return AuthorizationResponse.fromMap(params);
  }
}
