class ChatInfoModel {
  final String nombre;
  final String inicial;
  final String estado;

  ChatInfoModel({
    required this.nombre,
    required this.inicial,
    required this.estado,
  });

  factory ChatInfoModel.fromJson(Map<String, dynamic> json) {
    return ChatInfoModel(
      nombre: json['nombre'],
      inicial: json['inicial'],
      estado: json['estado'],
    );
  }
}
