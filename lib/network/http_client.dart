import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpClient {
  static const _baseURL = 'https://rel.ink/api';
  final _httpClient = http.Client();

  Future<Response> postRequest(
    String endpoint, {
    Map<String, String> headers = const {'Accept': 'application/json'},
    dynamic body,
  }) async {
    String url = "$_baseURL/$endpoint";
    print('Network Request : $url');
    return await _httpClient.post(
      url,
      headers: headers,
      body: body,
    );
  }

}
