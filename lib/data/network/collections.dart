import 'package:flutter_dotenv/flutter_dotenv.dart';

class Collections{

  // base url
  static const String gptUrl = 'https://api.openai.com/v1/chat/completions';

  static final String key = dotenv.env['OPENAI_API_KEY']!.replaceAll('_', ' ');

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 250000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 250000);

  static const String users = 'users';
}