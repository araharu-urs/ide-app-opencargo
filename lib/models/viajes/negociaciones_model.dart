class OfertaEnProcesoModel {
  final int idOferta;
  final String tipo;
  final String estado;
  final String fecha;
  final String origen;
  final String destino;
  final String paso_actual;
  final int viajeId;

  OfertaEnProcesoModel({
    required this.idOferta,
    required this.tipo,
    required this.estado,
    required this.fecha,
    required this.origen,
    required this.destino,
    required this.viajeId,
     required this.paso_actual,
  });

  factory OfertaEnProcesoModel.fromJson(Map<String, dynamic> json) {
    return OfertaEnProcesoModel(
      idOferta: json['id_oferta'],
      tipo: json['tipo'],
      estado: json['estado'],
      fecha: json['fecha'],
      origen: json['origen'],
      destino: json['destino'],
      viajeId: json['viaje_id'],
      paso_actual: json['paso_actual'],
    );
  }

  static List<OfertaEnProcesoModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => OfertaEnProcesoModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id_oferta': idOferta,
      'tipo': tipo,
      'estado': estado,
      'fecha': fecha,
      'origen': origen,
      'destino': destino,
      'viaje_id': viajeId,
      'paso_actual': paso_actual,
    };
  }
}
