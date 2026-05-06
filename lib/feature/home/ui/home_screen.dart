import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_path.dart';
import '../../../core/widget/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: HomeBody());
  }
}

// 1. 별도의 클래스로 추출
class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/leximatch_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: const _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset(
                  'assets/images/leximatch_title_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Align(
              alignment: const Alignment(0, 0.6), // 아래로 이동
              child: Image.asset(
                'assets/images/ic_home_lodo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: LexiGameButton(
                text: "게임 시작",
                width: 150,
                height: 50,
                onTap: () {
                  context.go(RoutePath.game);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
