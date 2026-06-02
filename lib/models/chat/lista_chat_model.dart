class ChatResumenModel {
  final int id;
  final String nombre;
  final String inicial;
  final String ultimoMensaje;
  final String horaUltimoMensaje;

  ChatResumenModel({
    required this.id,
    required this.nombre,
    required this.inicial,
    required this.ultimoMensaje,
    required this.horaUltimoMensaje,
  });

  // 🔹 Convertir JSON a Modelo
  factory ChatResumenModel.fromJson(Map<String, dynamic> json) {
    return ChatResumenModel(
       id: json['id'],
      nombre: json['nombre'],
      inicial: json['inicial'],
      ultimoMensaje: json['ultimo_mensaje'],
      horaUltimoMensaje: json['hora_ultimo_mensaje'],
    );
  }

  // 🔹 Convertir Modelo a JSON
  Map<String, dynamic> toJson() {
    return {
       'id': id,
      'nombre': nombre,
      'inicial': inicial,
      'ultimo_mensaje': ultimoMensaje,
      'hora_ultimo_mensaje': horaUltimoMensaje,
    };
  }

  // 🔹 Convertir una lista de JSON a Lista de Modelos
  static List<ChatResumenModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ChatResumenModel.fromJson(item)).toList();
  }
}
