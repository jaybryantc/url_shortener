import 'dart:convert';

import 'package:url_shortener/network/http_client.dart';

class URLRepository {

  Future<String> getShortenURL(String longURL) async {
    String endpoint = '/api/links';
    var body = Map<String, String>();
    body['url'] = longURL;
    final response = await postRequest(endpoint, body: body);
    if (response.statusCode == 200) {
      response.transform(utf8.decoder).listen((data) {
        return 'https://rel.ink/api/links/${jsonDecode(data)['hashid']}';
      });
    }

    return error_string;
  }

}
