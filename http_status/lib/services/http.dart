import 'package:http/http.dart' as http;

class Http {
  static const _server = 'https://httpcats.com';

  static get(int codigo) async {
    var response = await http.get(Uri.parse('$_server/$codigo.json'));
    return response.body;
  }
}
