
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/game/ui/providers/game_state_provider.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameStateProvider);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            print("버튼 눌림");
            ref.read(gameStateProvider.notifier).fetchGameData();
          },
          child: const Text("데이터 가져오기"),
        ),
      ),
    );
  }
}
