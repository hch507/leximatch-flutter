
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_path.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Splash Screen"),
          ElevatedButton(
            onPressed: () {
                context.go(RoutePath.home);
            },
            child: const Text("홈으로 이동"),
          )
        ],
      ),
    );
  }
}
