OAuth1 Fluig Totvs
===========

This lib is provide by using core of https://pub.dev/packages/oauth1. Thanks.

Usage
-----

Add to `pubspec.yaml`:

```yaml
dependencies:
  fluig_oauth1: ^1.2.0
```

Please use like below.

```dart
import 'dart:convert';
import 'package:fluig_oauth1/fluig_oauth1.dart';

void main() {

  String url = "<url_fluig>";

  const String apiKey = '<client_token>';
  const String apiSecret = '<client_token_secret>';
  var clientCredentials = ClientCredentials(apiKey, apiSecret);

  var user = User("<user>","<pass>");

  var fluigConnect = FluigConnect(url,clientCredentials,user);

  var getCurrentURI = Uri.parse(url + 'api/public/2.0/users/getCurrent');

  fluigConnect
      .connect()
      .then((client) => {

            client.get(getCurrentURI).then((res) {
              print(res.body);
            })

          })
      .catchError((err) {
          print("mostrando erro: " + err.toString());
      });

  var listURI = Uri.parse(url + 'api/public/2.0/folderdocuments/listDocumentByFolder');

  final Map<String, String> headers = new Map<String, String>();
  headers['Content-Type'] = "application/json";

  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['documentId'] = "2";
  var body = jsonEncode(data);

  fluigConnect
      .connect()
      .then((client) => {

            client.post(listURI, headers: headers, body: body).then((res) {
              print(res.body);
            })

          })
      .catchError((err) {
        print("mostrando erro: " + err.toString());
      });

}


```

