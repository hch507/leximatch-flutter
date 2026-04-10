import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/core/router/app_router.dart';

void main() {
  runApp(const ProviderScope( // ⭐️ 이거 필수
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'LexiMatch',
    );
  }
}

