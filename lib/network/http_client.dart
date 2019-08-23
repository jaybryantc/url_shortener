import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const _base_url = 'api-ssl.bitly.com';
const _token = '7077bbfc821259fae9f34bbc9f7d6047b0493b97';
const String error_string = 'Unable to shorten url';
final httpClient = http.Client();

Future<http.StreamedResponse> postRequest(
  String endpoint, {
  Map<String, String> headers,
  Map<String, String> body,
}) async {
  String url = "$_base_url/$endpoint";
  print('Network Request : $url');

  http.Request request = http.Request("POST",Uri.https(_base_url, endpoint));
  Map<String, String> requestHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $_token',
  };
  if (headers != null) {
    requestHeaders.addAll(headers);
  }

  request.headers.addAll(requestHeaders);
  request.body = jsonEncode(body);

  return await httpClient.send(request);
}
