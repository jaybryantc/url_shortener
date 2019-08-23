import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  HomeState([List props = const []]) : super(props);
}

class HomeInitial extends HomeState {
  @override
  String toString() => 'Home Initial';
}

class HomeLoading extends HomeState {
  @override
  String toString() => 'Home Loading';
}

class HomeSuccessful extends HomeState {
  HomeSuccessful(this.shortenURL);

  final String shortenURL;

  @override
  String toString() => 'Home Successful : $shortenURL';
}

class HomeFailure extends HomeState {
  HomeFailure(this.error);

  final error;
  @override
  String toString() => 'Home Failure : $error';
}

class CopyToClipboardSuccessful extends HomeState {
  CopyToClipboardSuccessful();

  @override
  String toString() => 'Copy to clipboard successful';
}

class CopyToClipboardFailure extends HomeState {
  CopyToClipboardFailure();

  @override
  String toString() => 'Copy to clipboard failed';
}