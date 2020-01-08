OAuth1 Fluig Totvs
===========

This lib is provide by using core of https://pub.dev/packages/oauth1. Thanks.

Usage
-----

Add to `pubspec.yaml`:

```yaml
dependencies:
  fluig_oauth1: ^1.0.0
```

Please use like below.

```dart
import 'package:fluig_oauth1/fluig_oauth1.dart';

void main() {

  String url = "<url_fluig>";

  const String apiKey = '<client_token>';
  const String apiSecret = '<client_token_secret>';
  var clientCredentials = ClientCredentials(apiKey, apiSecret);

  var user = User("<user>","<pass>");

  var fluigConnect = FluigConnect(url,clientCredentials,user);

  fluigConnect.connect().then((client) => {

    client. get (url + 'api/public/2.0/users/getCurrent').then((res) {

      print(res.body);

    })

  }).catchError((err) {

    print("mostrando erro: "+err.toString());

  });

}


```

