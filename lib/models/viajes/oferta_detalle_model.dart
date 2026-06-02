class OfertaDetalleModel {
  final int id;
  final String name;
  final String email;
  final String estado;
  final String tipo;
  final String? precioFull;
  final String? cantidadFull;
  final String? precioSencillo;
  final String? cantidadSencillo;
  final String? cantidad; // Solo para "Tomar Carga"

  OfertaDetalleModel({
    required this.id,
    required this.name,
    required this.email,
    required this.estado,
    required this.tipo,
    this.precioFull,
    this.cantidadFull,
    this.precioSencillo,
    this.cantidadSencillo,
    this.cantidad,
  });

  /// 📌 Convierte un JSON en un objeto `OfertaDetalleModel`
  factory OfertaDetalleModel.fromJson(Map<String, dynamic> json) {
    return OfertaDetalleModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      estado: json['estado'],
      tipo: json['tipo'],
      precioFull: json['precio_full']?.toString(),
      cantidadFull: json['cantidad_full']?.toString(),
      precioSencillo: json['precio_sencillo']?.toString(),
      cantidadSencillo: json['cantidad_sencillo']?.toString(),
      cantidad: json['cantidad']?.toString(),
    );
  }

  /// 📌 Convierte un objeto `OfertaDetalleModel` a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'estado': estado,
      'tipo': tipo,
      'precio_full': precioFull,
      'cantidad_full': cantidadFull,
      'precio_sencillo': precioSencillo,
      'cantidad_sencillo': cantidadSencillo,
      'cantidad': cantidad,
    };
  }
}
