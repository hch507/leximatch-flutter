
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
    return Center(
      child: Text("결과 화면"),
    );
  }
}

