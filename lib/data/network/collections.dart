import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Collections{

  // GPT Endpoints
  static const String gptUrl = 'https://api.openai.com/v1/chat/completions';
  static final  String openApiKey = utf8.decode(base64.decode('QmVhcmVyIHNrLUVvWVEzSXZMZzdBTDEyTkhwVTJTVDNCbGJrRkpyRXRxWXZvbjRpVHFQM0dCSXdkTQ=='));

  // Quotes Endpoints
  static const String quoteUrl = 'https://api.api-ninjas.com/v1/quotes';
  static final  String quoteApiKey = utf8.decode(base64.decode('Q0VWcmk1bE1hdTNkVjNkMndrdzVWZz09d09aQTN5V1JSZUx2aDREZA=='));

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 250000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 250000);

  static const String users = 'users';
}
