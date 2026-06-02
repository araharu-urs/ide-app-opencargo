class ViajeModel {
  final int id;
  final int usersId;
  final String estado;
  final String? flota;
  final DateTime createdAt;
  final DateTime updatedAt;

  final String fechaSalida;
  final String fechaLlegada;
  final String codigoPostalOrigen;
  final String codigoPostalDestino;
  final String lugarOrigen;
  final String lugarDestino;
  final String noContenedores;
  final String tamContenedorNum;
  final String tamContenedorTipo;
  final String pesoMin;
  final String pesoMax;
  final String modalidad;
  final String precioFull;
  final String precioSencillo;
  final String tipo_venta;
  final String contenedoresTomados;

  ViajeModel({
    required this.id,
    required this.usersId,
    required this.estado,
    this.flota,
    required this.createdAt,
    required this.updatedAt,
    required this.fechaSalida,
    required this.fechaLlegada,
    required this.codigoPostalOrigen,
    required this.codigoPostalDestino,
    required this.lugarOrigen,
    required this.lugarDestino,
    required this.noContenedores,
    required this.tamContenedorNum,
    required this.tamContenedorTipo,
    required this.pesoMin,
    required this.pesoMax,
    required this.modalidad,
    required this.precioFull,
    required this.precioSencillo,
    required this.tipo_venta,
    required this.contenedoresTomados,
  });

  factory ViajeModel.fromJson(Map<String, dynamic> json) {
    return ViajeModel(
      id: json['id'],
      usersId: json['users_id'],
      estado: json['estado'],
      flota: json['flota'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      fechaSalida: json['fecha_salida'],
      fechaLlegada: json['fecha_llegada'],
      codigoPostalOrigen: json['codigo_postal_origen'],
      codigoPostalDestino: json['codigo_postal_destino'],
      lugarOrigen: json['lugar_origen'],
      lugarDestino: json['lugar_destino'],
      noContenedores: json['no_contenedores'],
      tamContenedorNum: json['tam_contenedor_num'],
      tamContenedorTipo: json['tam_contenedor_tipo'],
      pesoMin: json['peso_min'],
      pesoMax: json['peso_max'],
      modalidad: json['modalidad'],
      precioFull: json['precio_full'],
      precioSencillo: json['precio_sencillo'],
      tipo_venta: json['tipo_venta'],
      contenedoresTomados: json['contenedores_tomados']
    );
  }

  static List<ViajeModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ViajeModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'users_id': usersId,
      'estado': estado,
      'flota': flota,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'fecha_salida': fechaSalida,
      'fecha_llegada': fechaLlegada,
      'codigo_postal_origen': codigoPostalOrigen,
      'codigo_postal_destino': codigoPostalDestino,
      'lugar_origen': lugarOrigen,
      'lugar_destino': lugarDestino,
      'no_contenedores': noContenedores,
      'tam_contenedor_num': tamContenedorNum,
      'tam_contenedor_tipo': tamContenedorTipo,
      'peso_min': pesoMin,
      'peso_max': pesoMax,
      'modalidad': modalidad,
      'precio_full': precioFull,
      'precio_sencillo': precioSencillo,
      'tipo_venta': tipo_venta,
      'contenedoresTomados':contenedoresTomados
    };
  }
}
