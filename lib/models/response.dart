import 'package:flutter/cupertino.dart';

class Response {
  Response({
    @required this.success,
    @required this.shortenURL,
    this.error,
  });
  bool success;
  String shortenURL;
  String error;
}
