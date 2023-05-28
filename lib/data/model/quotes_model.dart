import 'dart:convert';

QuotesModel quotesModelFromJson(dynamic data) => List<QuotesModel>.from(
      (data as List<dynamic>).map(
        QuotesModel.fromJson,
      ),
    )[0];

class QuotesModel {

  QuotesModel({
    this.quote,
  });

  factory QuotesModel.fromJson(dynamic json) => QuotesModel(
        quote: json['quote'] as String,
      );
  String? quote;
}
