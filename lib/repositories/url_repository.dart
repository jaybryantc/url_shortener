import 'dart:convert';

import 'package:url_shortener/constants.dart';
import 'package:url_shortener/models/response.dart';
import 'package:url_shortener/network/http_client.dart';

class URLRepository {

  Future<Response> getShortenURL(String longURL) async {
    String endpoint = '/v4/bitlinks';
    var body = Map<String, String>();
    body['long_url'] = longURL;
    var shortenURL;
    var message = unable_to_shorten_error;
    final response = await postRequest(endpoint, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      shortenURL = jsonDecode(await response.stream.bytesToString())['link'];
      return Response(success: true, shortenURL: shortenURL);
    } else if (response != null){
      message = jsonDecode(await response.stream.bytesToString())['message'];
      return Response(success: false, shortenURL: null, error: message);
    }
    return Response(success: false, shortenURL: null, error: message);
  }

}
