library authorization_test;

import 'package:fluig_oauth1/src/fluig_connect.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:fluig_oauth1/fluig_oauth1.dart' as oauth1;

void main() {
//  final Platform twitter1_1 = Platform(
//      'https://api.twitter.com/oauth/request_token',
//      'https://api.twitter.com/oauth/authorize',
//      'https://api.twitter.com/oauth/access_token',
//      SignatureMethods.hmacSha1);
//  const String apiKey = 'LLDeVY0ySvjoOVmJ2XgBItvTV';
//  const String apiSecret = 'JmEpkWXXmY7BYoQor5AyR84BD2BiN47GIBUPXn3bopZqodJ0MV';
//  final ClientCredentials clientCredentials =
//      ClientCredentials(apiKey, apiSecret);
//
//  test('request temporary credentials', () {
//    final Authorization auth =
//        Authorization(clientCredentials, twitter1_1, http.Client());
//    return auth.requestTemporaryCredentials();
//  });

  TesteFluig testeFluig = new TesteFluig();

  testeFluig.testarFluig();
}

class TesteFluig {
  String url = "https://clientes.totvsrp.com.br/";

  void testarFluig() {

//    print("Criando credential");
    // define client credentials (consumer keys)
    const String apiKey = '03c78ad081738a6228e0cf2b2fd9f3350db380c3';
    const String apiSecret = '03c78ad081738a6228e0cf2b2fd9f3350db380c303c78ad081738a6228e0cf2b2fd9f3350db380c3';
    var clientCredentials = oauth1.ClientCredentials(apiKey, apiSecret);

//    print("Criando User");
    var user = oauth1.User("admin_escandinavia","Admin@123");


    var fluigConnect = FluigConnect(url,clientCredentials,user);

    fluigConnect.connect().then((client) => {

      client. get (url + 'api/public/2.0/users/getCurrent').then((res) {
        print(res.body);
      })

    }).catchError((err) {
      print("mostrando erro: "+err.toString());
    });

//    print("Criando Authorization");
//
//    // create Authorization object with client credentials and platform definition
//    var auth = oauth1.Authorization(clientCredentials, platform);
//
//    print("Criando Request");
//
//    auth.requestTemporaryCredentials('oob').then((res) {
//      var client = new oauth1.Client(
//          platform.signatureMethod, clientCredentials, res.credentials);
//
//      client.get(url + 'api/public/2.0/users/getCurrent').then((res) {
//        print(res.body);
//      });
//    });

//    auth.requestTokenCredentials(credentials, "oob").then((res){
//
//      print("retorno: "+res.toString());
//
//    });

//    // request temporary credentials (request tokens)
//    auth.requestTemporaryCredentials('oob').then((res) {
//      // redirect to authorization page
//      print("Open with your browser: ${auth.getResourceOwnerAuthorizationURI(res.credentials.token)}");
//
//      // get verifier (PIN)
//      stdout.write("PIN: ");
//      String verifier = stdin.readLineSync();
//
//      // request token credentials (access tokens)
//      return auth.requestTokenCredentials(res.credentials, verifier);
//    }).then((res) {
//      // yeah, you got token credentials
//      // create Client object
//      var client = new oauth1.Client(
//          platform.signatureMethod, clientCredentials, res.credentials);
//
//      // now you can access to protected resources via client
//      client.get(url + 'api/public/2.0/users/getCurrent').then((res) {
//        print(res.body);
//      });
//
//      // NOTE: you can get optional values from AuthorizationResponse object
//      print("Your screen name is " + res.optionalParameters['screen_name']);
//    });
  }
}

class TesteFluigChave {
  String url = "https://clientes.totvsrp.com.br/";

  void testarFluig() {
    // define platform (server)
    var platform = new oauth1.Platform(
        url + 'portal/api/rest/oauth/request_token',
        // temporary credentials request
        url + 'portal/api/rest/oauth/authorize', // resource owner authorization
        url + 'portal/api/rest/oauth/access_token', // token credentials request
        oauth1.SignatureMethods.hmacSha1 // signature method
        );

    // define client credentials (consumer keys)
    const String apiKey = '03c78ad081738a6228e0cf2b2fd9f3350db380c3';
    const String apiSecret =
        '03c78ad081738a6228e0cf2b2fd9f3350db380c303c78ad081738a6228e0cf2b2fd9f3350db380c3';
    final clientCredentials = new oauth1.ClientCredentials(apiKey, apiSecret);

//    const String userKey = 'd140915e-9b07-4d53-be42-c42cbd85f5d1';
//    const String userSecret =
//        'fec93543-77d7-4635-9fb4-810d7492c89a35976754-fbd8-4809-8518-b461b98c6a3f';

    const String userKey = '039982af-8f30-4695-ad04-311daf28d655';
    const String userSecret =
        'a3edd43f-d4b7-46f4-b952-9cdf89a39a4fc66fc055-6b5b-4fe3-bef2-806384b83d8a';

    oauth1.Credentials credentials =
        new oauth1.Credentials(userKey, userSecret);

    final client = new oauth1.Client(
        platform.signatureMethod, clientCredentials, credentials);

    client.get(url + 'api/public/2.0/users/getCurrent').then((res) {
      print(res.body);
    });

//    auth.requestTokenCredentials(credentials, "oob").then((res){
//
//      print("retorno: "+res.toString());
//
//    });

//    // request temporary credentials (request tokens)
//    auth.requestTemporaryCredentials('oob').then((res) {
//      // redirect to authorization page
//      print("Open with your browser: ${auth.getResourceOwnerAuthorizationURI(res.credentials.token)}");
//
//      // get verifier (PIN)
//      stdout.write("PIN: ");
//      String verifier = stdin.readLineSync();
//
//      // request token credentials (access tokens)
//      return auth.requestTokenCredentials(res.credentials, verifier);
//    }).then((res) {
//      // yeah, you got token credentials
//      // create Client object
//      var client = new oauth1.Client(
//          platform.signatureMethod, clientCredentials, res.credentials);
//
//      // now you can access to protected resources via client
//      client.get(url + 'api/public/2.0/users/getCurrent').then((res) {
//        print(res.body);
//      });
//
//      // NOTE: you can get optional values from AuthorizationResponse object
//      print("Your screen name is " + res.optionalParameters['screen_name']);
//    });
  }
}
