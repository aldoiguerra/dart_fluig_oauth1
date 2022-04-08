library fluig_connect;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'signature_method.dart';
import 'client_credentials.dart';
import 'credentials.dart';
import 'user.dart';
import 'client.dart';
import 'platform.dart';
import 'authorization.dart';
import 'authorization_response.dart';

/// A class describing OAuth client credentials.
class FluigConnect {
  final SignatureMethod _signatureMethod = SignatureMethods.hmacSha1;
  final ClientCredentials _clientCredentials;
  final Credentials _credentials;
  final User _user;
  final String _url;
  final http.BaseClient _httpClient;

  FluigConnect(this._url, this._clientCredentials, this._user, [this._credentials, http.BaseClient httpClient]) : _httpClient = httpClient != null ? httpClient : http.Client();

  Future<Client> connect() async {
//    print("Criando plataform");
    final platform = Platform(
        _url + 'portal/api/rest/oauth/request_token',
        _url + 'portal/api/rest/oauth/authorize',
        // resource owner authorization
        _url + 'portal/api/rest/oauth/access_token',
        // token credentials request
        _signatureMethod // signature method
        );

//    print("Criando Authorization");
    // create Authorization object with client credentials and platform definition
    var auth = Authorization(_clientCredentials, platform, _httpClient);

//    print("Criando Request para token com usuaário e senha");

    AuthorizationResponse res = null;

    res = await auth.requestTemporaryCredentials('oob');

    final int code = await requestAuthenticate(res);

    res = await auth.requestTokenCredentials(res.credentials, "");

//    print("user token: " + res.credentials.token);
//    print("user token secret: " + res.credentials.tokenSecret);

    return Client(platform.signatureMethod, _clientCredentials, res.credentials);
  }

  /// Obtain a set of temporary credentials from the server.
  /// http://tools.ietf.org/html/rfc5849#section-2.1
  ///
  /// If not callbackURI passed, authentication becomes PIN-based.
  Future<int> requestAuthenticate(AuthorizationResponse res) async {
    final encoding = Encoding.getByName("utf-8");
    final body = Uri.encodeFull("login=" + _user.user + "&password=" + _user.password + "&oauth_token=" + res.credentials.token + "&oauth_callback=oob");

//    print("Requisitanto login to: " + _url + 'portal/api/rest/oauth/dologin');
//    print("Body: " + body);

    Uri dologinURI = Uri.parse(_url + 'portal/api/rest/oauth/dologin');

    final http.Response resLogin = await _httpClient.post(
      dologinURI,
      headers: <String, String>{'Content-Type': 'application/x-www-form-urlencoded', 'Accept': 'text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2'},
      body: body,
    );

//    print('Resposta statusCode: ' + resLogin.statusCode.toString());
//    print("Resposta body: " + resLogin.body);

    if (resLogin.statusCode != 200) {
      throw StateError(resLogin.body);
    }

    return resLogin.statusCode;
  }
}
