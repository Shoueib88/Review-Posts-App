import 'package:flutter/material.dart';

import '../app_theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 20),
      child: Center(child: CircularProgressIndicator(color: secondaryColor)),
    );
  }
}
