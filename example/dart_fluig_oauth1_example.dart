import 'package:fluig_oauth1/fluig_oauth1.dart';

void main() {

  String url = "<url>";

  const String apiKey = '<token>';
  const String apiSecret = '<token_secret>';
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
