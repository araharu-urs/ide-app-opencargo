class LoginResponse {
  final String accessToken;
  final String tokenType;
  final User user;

  LoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  // Método para convertir JSON a objeto LoginResponse
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }
}

// Modelo para representar el usuario dentro de la respuesta
class User {
  final int id;
  final String name;
  final String email;
  final String rol;
  final String imagen;
  final String token_notificacion;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.imagen,
    required this.rol,
    required this.token_notificacion,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      imagen: json['imagen'] ?? '',
      rol: json['rol'] ?? '',
      token_notificacion: json['token_notificacion'] ?? '',
    );
  }
}
