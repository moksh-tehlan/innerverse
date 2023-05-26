import 'dart:convert';

GptModel gptModelFromJson(String str) =>
    GptModel.fromJson(jsonDecode(str) as Map<String, dynamic>);

class GptModel {
  GptModel({
    this.choices,
  });

  factory GptModel.fromJson(Map<String, dynamic> json) => GptModel(
        choices: List<Choice>.from(
          (json['choices'] as List<dynamic>)
              .map((x) => Choice.fromJson(x as Map<String, dynamic>)),
        ),
      );
  final List<Choice>? choices;
}

class Choice {
  Choice({
    this.message,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
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
