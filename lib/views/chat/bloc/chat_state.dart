part of 'chat_bloc.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.initial() = _Initial;
  const factory ChatState.loading() = _Loading;
  const factory ChatState.messageSent() = _MessageSent;
  const factory ChatState.response() = _Response;
  const factory ChatState.error({required String error}) = _Error;
}
