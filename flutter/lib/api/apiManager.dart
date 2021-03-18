import 'package:http/http.dart' as http;

class ApiManager {
  Future<http.Response> get(String url) async {
    var client = http.Client();
    var response = await client.get(url);
    return response;
  }
}
