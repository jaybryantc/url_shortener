import 'dart:convert';
import 'dart:io';

const _base_url = 'rel.ink';
const String error_string = 'Unable to shorten url';
final httpClient = HttpClient();

Future<HttpClientResponse> postRequest(
    String endpoint, {
      Map<String, String> headers = const {'Accept':'application/json'},
      Map<String, String> body,
    }) async {
  String url = "$_base_url/$endpoint";
  print('Network Request : $url');
  HttpClientRequest request = await httpClient.postUrl(Uri.https(_base_url, endpoint));
  headers.forEach((key,value) => request.headers.add(key, value));
  request.headers.contentType = ContentType.json;
  request.add(utf8.encode(json.encode(body)));
  return await request.close();
}