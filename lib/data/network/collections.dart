class Collections{

  // base url
  static const String gptUrl = 'https://api.openai.com/v1/chat/completions';

  static const String key = 'Bearer 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';

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 250000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 250000);

  static const String users = 'users';
}