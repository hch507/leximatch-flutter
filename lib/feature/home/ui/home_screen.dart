import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_path.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Home Screen"),
          ElevatedButton(
            onPressed: () {
              print("게임으로 이동");
              context.go(RoutePath.game);
            },
            child: const Text("게임으로 이동"),
          )
        ],
      ),
    );
  }
}
