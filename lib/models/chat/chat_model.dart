class MensajeModel {
  final int id;
  final String contenido;
  final String createdAt;
  final String updatedAt;
  final int chatsId;
  final int userId;
  final String tipoMensaje;

  MensajeModel({
    required this.id,
    required this.contenido,
    required this.createdAt,
    required this.updatedAt,
    required this.chatsId,
    required this.userId,
    required this.tipoMensaje,
  });

  factory MensajeModel.fromJson(Map<String, dynamic> json) {
    return MensajeModel(
      id: json['id'],
      contenido: json['contenido'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      chatsId: json['chats_id'],
      userId: json['user_id'],
      tipoMensaje: json['tipo_mensaje'] ?? 'texto',
    );
  }

  static List<MensajeModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => MensajeModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contenido': contenido,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'chats_id': chatsId,
      'user_id': userId,
      'tipo_mensaje': tipoMensaje,
    };
  }
}
