import 'dart:convert';

// List<GptMessageModel> gptMessageModelList = [
//   GptMessageModel(
//     role: 'system',
//     content:
//         'you are a helpful friend who helps in difficult time as a true friend don\'t reply in big sentences try to short and simple and helpful after every conversation you have to ask user if you can help in any other way.',
//   )
// ];

List<GptMessageModel> gptMessageModelFromJson(String str) =>
    List<GptMessageModel>.from(
      (jsonDecode(str) as List<dynamic>)
          .map((x) => GptMessageModel.fromJson(x as Map<String, dynamic>)),
    );

List<Map<String, dynamic>> gptMessageModelToList(List<GptMessageModel> data) =>
    data.map((x) => x.toJson()).toList();

class GptMessageModel {
  GptMessageModel({
    this.role,
    this.content,
  });

  factory GptMessageModel.fromJson(Map<String, dynamic> json) =>
      GptMessageModel(
        role: json['role'] as String,
        content: json['content'] as String,
      );
  String? role;
  String? content;

  Map<String, dynamic> toJson() => {
        'role': role,
        'content': content,
  };

  @override
  String toString() {
    return 'GptMessageModel{role: $role, content: $content}';
  }
}
