import 'dart:convert';

class UserModel {
  final String name;
  final String description;
  final String rol;
 final String initial;
  UserModel({
    required this.name,
    required this.description,
    required this.rol,
    required this.initial
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      description: json['description'],
      rol: json['rol'],
      initial: json['initial'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'rol': rol,
      'initial':initial
    };
  }

  static List<UserModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => UserModel.fromJson(item)).toList();
  }
}
