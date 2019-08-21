import 'dart:convert';

import 'package:url_shortener/network/http_client.dart';

class URLRepository {
  Future<String> getShortenURL(String longURL) async {
    String endpoint = 'links';
    String body = '{url:$longURL}';
    final response = await HttpClient().postRequest(endpoint, body: jsonEncode(body));
    if (response.statusCode == 200) {
      return 'https://rel.ink/api/links/${jsonDecode(response.body)['hashid']}';
    }

    return 'Unable to shorten url';
  }

}
