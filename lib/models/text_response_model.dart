import 'dart:convert';

TextResponseModel textResponseModelFromMap(String str) => TextResponseModel.fromMap(json.decode(str));

String testResponseModelToMap(TextResponseModel data) => json.encode(data.toMap());

class TextResponseModel {
  String? id;
  String? text;

  TextResponseModel({
    this.id,
    this.text,
  });

  factory TextResponseModel.fromMap(Map<String, dynamic> json) => TextResponseModel(
    id: json["id"]?.toString(),
    text: json["text"]?.toString(),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "text": text,
  };
}
