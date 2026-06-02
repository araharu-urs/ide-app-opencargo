class UsuarioOfertaModel {
  final int id;
  final String name;
  final String email;
  final String tipo;
  final int id_oferta;
  final String estado;
  final String? flota;
  final String? precioFull;
  final String? cantidadFull;
  final String? precioSencillo;
  final String? cantidadSencillo;
  final String? cantidad;
  final String? createdAt;
  final String? updatedAt;

  UsuarioOfertaModel({
    required this.id,
    required this.name,
    required this.email,
    required this.id_oferta,
    required this.tipo,
    required this.estado,
    this.flota,
    this.precioFull,
    this.cantidadFull,
    this.precioSencillo,
    this.cantidadSencillo,
    this.cantidad,
    this.createdAt,
    this.updatedAt,
  });

  /// 📌 Convierte un JSON en un objeto `UsuarioOfertaModel`
  factory UsuarioOfertaModel.fromJson(Map<String, dynamic> json) {
    return UsuarioOfertaModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      tipo: json['tipo'],
      id_oferta: json['id_oferta'],
      estado: json['estado'],
      flota: json['flota'],
      precioFull: json['precio_full']?.toString(),
      cantidadFull: json['cantidad_full']?.toString(),
      precioSencillo: json['precio_sencillo']?.toString(),
      cantidadSencillo: json['cantidad_sencillo']?.toString(),
      cantidad: json['cantidad']?.toString(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  /// 📌 Convierte una lista de JSON en una lista de `UsuarioOfertaModel`
  static List<UsuarioOfertaModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => UsuarioOfertaModel.fromJson(item)).toList();
  }

  /// 📌 Convierte un objeto `UsuarioOfertaModel` a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'tipo': tipo,
       'id_oferta': tipo,
      'estado': estado,
      'flota': flota,
      'precio_full': precioFull,
      'cantidad_full': cantidadFull,
      'precio_sencillo': precioSencillo,
      'cantidad_sencillo': cantidadSencillo,
      'cantidad': cantidad,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
