import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:url_shortener/constants.dart';
import 'package:url_shortener/models/response.dart';
import 'package:url_shortener/repositories/url_repository.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.urlRepository) : assert(urlRepository != null);

  final URLRepository urlRepository;

  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is ShortenURLPressed) {
      if (event.url.trim().isEmpty) {
        yield HomeFailure(no_url_error);
      } else {
        try {
          Uri.parse(event.url.trim());
        } catch(error) {
          yield HomeFailure(invalid_url_error);
        }
      }

      yield HomeLoading();
      try {
        Response response = await urlRepository.getShortenURL(event.url);
        if(response.success) {
          yield HomeSuccessful(response.shortenURL);
        } else {
          yield HomeFailure(response.error);
        }
      } catch(error) {
        yield HomeFailure(error);
      }
    } else if (event is LinkCopied) {
      Clipboard.setData(ClipboardData(text: event.shortUrl));
      yield CopyToClipboardSuccessful();
    } else if (event is LinkCopied) {
      await Clipboard.setData(ClipboardData(text: event.shortUrl));
      yield CopyToClipboardSuccessful();
    }
  }
}
