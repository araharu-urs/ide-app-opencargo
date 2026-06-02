import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cargo/constantes.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("about_title".tr,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        backgroundColor: ThemeUi.principal,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/closca-app.appspot.com/o/open%20cargomorado.png?alt=media&token=2d882778-427f-480a-a732-7338968e802e',
                    height: 120,
                  ),
                  const SizedBox(height: 10),
                  Text("Open Cargo",
                      style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold)),
                  Text(
                    "version".tr,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.hintColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildSectionTitle("about_what_title".tr, theme),
            _buildParagraph("about_what_desc".tr, theme),
            _buildDivider(),
            _buildSectionTitle("about_features_title".tr, theme),
            _buildBulletPoint("about_feature_1".tr, theme),
            _buildBulletPoint("about_feature_2".tr, theme),
            _buildBulletPoint("about_feature_3".tr, theme),
            _buildBulletPoint("about_feature_4".tr, theme),
            _buildDivider(),
            const Spacer(),
            Center(
              child: Text(
                "copyright".tr,
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title,
          style: theme.textTheme.titleSmall
              ?.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildParagraph(String text, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text,
          style: theme.textTheme.bodyMedium?.copyWith(height: 1.5)),
    );
  }

  Widget _buildBulletPoint(String text, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.blueAccent, size: 18),
          const SizedBox(width: 8),
          Expanded(
              child: Text(text, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Divider(color: Colors.grey[300]),
    );
  }
}
