part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial({required String quote}) = _Initial;
  const factory HomeState.loadQuote({required String quote}) = _LoadQuote;
  const factory HomeState.error({required String error}) = _Error;
}
