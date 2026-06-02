class OfertaProcesoDetalleModel {
  final int idOferta;
  final String tipo;
  final String estado;
  final String fecha;
  final String origen;
  final String destino;
  final int viajeId;
  final int pasoActual;
  final UsuarioModel usuario;
  final int chatId;

  OfertaProcesoDetalleModel({
    required this.idOferta,
    required this.tipo,
    required this.estado,
    required this.fecha,
    required this.origen,
    required this.destino,
    required this.viajeId,
    required this.pasoActual,
    required this.usuario,
    required this.chatId,
  });

  factory OfertaProcesoDetalleModel.fromJson(Map<String, dynamic> json) {
    return OfertaProcesoDetalleModel(
      idOferta: json['id_oferta'],
      tipo: json['tipo'],
      estado: json['estado'],
      fecha: json['fecha'],
      origen: json['origen'],
      destino: json['destino'],
      viajeId: json['viaje_id'],
      pasoActual: int.tryParse(json['paso_actual'].toString()) ?? 0,
      usuario: UsuarioModel.fromJson(json['usuario']),
      chatId: json['chat_id'],
    );
  }
}

class UsuarioModel {
  final int id;
  final String name;
  final String email;

  UsuarioModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
