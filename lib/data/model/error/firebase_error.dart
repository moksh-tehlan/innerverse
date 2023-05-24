class FirebaseError {

  FirebaseError({required String code}) : _code = code;
  final String _code;

  String _message() {
    switch (_code) {
      case 'weak-password':
        return 'Password is too weak';
      case 'email-already-in-use':
        return 'Email already in use';
      case 'user-not-found':
        return 'Invalid email-id';
      case 'wrong-password':
        return 'Invalid password';
      default:
        return 'Something went wrong';
    }
  }

  String get message => _message();
}
