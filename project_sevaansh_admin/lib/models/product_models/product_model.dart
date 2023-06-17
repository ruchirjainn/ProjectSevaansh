import 'dart:convert';

CauseModel productModelFromJson(String str) =>
    CauseModel.fromJson(json.decode(str));

String productModelToJson(CauseModel data) => json.encode(data.toJson());

class CauseModel {
  CauseModel({
    required this.categoryId,
    required this.image,
    required this.id,
    required this.name,
    required this.description,
  });

  String image;
  String categoryId;
  String id;
  String name;
  String description;

  factory CauseModel.fromJson(Map<String, dynamic> json) => CauseModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        categoryId: json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "categoryId": categoryId,
      };
  CauseModel copyWith({
    String? name,
    String? description,
    String? image,
    String? id,
    String? categoryId,
  }) =>
      CauseModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
        categoryId: categoryId ?? this.categoryId,
      );
}
