import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://firebasestorage.googleapis.com/v0/b/closca-app.appspot.com/o/open%20cargomorado.png?alt=media&token=2d882778-427f-480a-a732-7338968e802e',
            height: 120,
          ),
          const SizedBox(height: 20),
          Text(
            "No datos disponibles",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "¡Intenta recargar o vuelve más tarde!",
            style: TextStyle(
              fontSize: 14,
              color: theme.hintColor,
            ),
          ),
        ],
      ),
    );
  }
}
