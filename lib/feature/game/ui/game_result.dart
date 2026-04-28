import 'package:flutter/material.dart';

class GameResult extends StatelessWidget {
  const GameResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameResultBody(),
    );
  }
}

class GameResultBody extends StatelessWidget {
  const GameResultBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/leximatch_result_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: _GameResultBody(),
    );
  }
}

class _GameResultBody extends StatelessWidget {
  const _GameResultBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsetsGeometry.fromLTRB(0, 20, 0, 0),
              child: Image.asset(
                'assets/images/result_comment_logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Image.asset(
              'assets/images/ic_lodo_result.png',
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(),
          )
        ],
      ),
    );
  }
}
