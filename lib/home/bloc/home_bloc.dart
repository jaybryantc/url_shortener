import 'package:bloc/bloc.dart';
import 'package:url_shortener/models/response.dart';
import 'package:url_shortener/network/http_client.dart';
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
    }
  }
}
