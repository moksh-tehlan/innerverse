import 'dart:convert';

GptModel gptModelFromJson(String str) =>
    GptModel.fromJson(jsonDecode(str));

class GptModel {
  GptModel({
    this.choices,
  });

  factory GptModel.fromJson(dynamic json) => GptModel(
        choices: List<Choice>.from(
          (json['choices'] as List<dynamic>)
              .map(Choice.fromJson),
        ),
      );
  final List<Choice>? choices;
}

class Choice {
  Choice({
    this.message,
  });

  factory Choice.fromJson(dynamic json) => Choice(
        message: Message.fromJson(json['message'] as Map<String, dynamic>),
      );
  final Message? message;
}

class Message {
  Message({
    this.role,
    this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json['role'] as String,
        content: json['content'] as String,
      );
  final String? role;
  final String? content;
}
