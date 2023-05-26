import 'dart:convert';

List<GptMessageModel> gptMessageModelFromJson(String str) =>
    List<GptMessageModel>.from(
      (json.decode(str) as List<dynamic>)
          .map((x) => GptMessageModel.fromJson(x as Map<String, dynamic>)),
    );

String gptMessageModelToJson(List<GptMessageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GptMessageModel {
  GptMessageModel({
    this.role,
    this.content,
    this.name,
  });

  factory GptMessageModel.fromJson(Map<String, dynamic> json) =>
      GptMessageModel(
        role: json['role'] as String,
        content: json['content'] as String,
        name: json['name'] as String,
      );
  String? role;
  String? content;
  String? name;

  Map<String, dynamic> toJson() => {
        'role': role,
        'content': content,
        'name': name,
      };
}
