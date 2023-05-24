class GenericError{
  GenericError({required String message}):_message = message;
  final String _message;
  String get message => _message;
}
