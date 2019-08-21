import 'package:bloc/bloc.dart';
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
        String shortenURL = await urlRepository.getShortenURL(event.url);
        yield HomeSuccessful(shortenURL);
      } catch(error) {
        yield HomeFailure(error);
      }
    }
  }
}
