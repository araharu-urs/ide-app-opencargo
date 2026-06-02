import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        children: [
          Image.network(
            'https://firebasestorage.googleapis.com/v0/b/closca-app.appspot.com/o/open%20cargomorado.png?alt=media&token=2d882778-427f-480a-a732-7338968e802e',
            height: 120,
          ),
          const SizedBox(height: 10),
          Text(
            "Welcome Back!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color:  const Color.fromARGB(255, 54, 5, 250),
            ),
          ),
        ],
      ),
    );
  }
}
