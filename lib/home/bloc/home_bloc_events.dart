import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const []]) : super(props);
}

class ShortenURLPressed extends HomeEvent {
  ShortenURLPressed(this.url) : super([url]);

  final String url;

  @override
  String toString() => 'Shorten URL Button is Pressed : $url';
}

class LinkCopied extends HomeEvent {
  LinkCopied(this.shortUrl) : super([shortUrl]);

  final String shortUrl;

  @override
  String toString() => 'Short URL is copied : $shortUrl';
}
