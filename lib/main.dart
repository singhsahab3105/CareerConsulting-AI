import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/dashboard_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: CareerConsultingApp()));
}

/// Separate widget so that you can easily add routes or localization later.
class CareerConsultingApp extends StatelessWidget {
  const CareerConsultingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Career Consulting-AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const DashboardScreen(),
    );
  }
}
