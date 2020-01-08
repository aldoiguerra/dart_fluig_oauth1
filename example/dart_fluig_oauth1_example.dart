import 'package:fluig_oauth1/fluig_oauth1.dart';

void main() {

  String url = "https://clientes.totvsrp.com.br/";

  const String apiKey = '03c78ad081738a6228e0cf2b2fd9f3350db380c3';
  const String apiSecret = '03c78ad081738a6228e0cf2b2fd9f3350db380c303c78ad081738a6228e0cf2b2fd9f3350db380c3';
  var clientCredentials = ClientCredentials(apiKey, apiSecret);

  var user = User("admin_escandinavia","Admin@123");

  var fluigConnect = FluigConnect(url,clientCredentials,user);

  fluigConnect.connect().then((client) => {

    client. get (url + 'api/public/2.0/users/getCurrent').then((res) {

      print(res.body);

    })

  }).catchError((err) {

    print("mostrando erro: "+err.toString());

  });

}
