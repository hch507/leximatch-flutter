import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/game/ui/providers/game_state_provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Column(
          children: [
            Expanded(child: InputSection()),
            Expanded(child: ResultSection())
          ],
        )
    );
  }
}

class InputSection extends ConsumerStatefulWidget {
  const InputSection({super.key});

  @override
  ConsumerState<InputSection> createState() => _InputSectionState();
}

class _InputSectionState extends ConsumerState<InputSection> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              hintText: "단어 업력",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                final text = _textEditingController.text;
                ref.read(gameStateProvider.notifier).fetchSimilarity(text);
              },
              child: const Text("유사도 체크")
          )
        ],
      ),
    );
  }
}

class ResultSection extends ConsumerWidget {
  const ResultSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameStateProvider);

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),

      error: (e, _) => Center(
        child: Text("에러: $e"),
      ),

      data: (list) {
        if (list.isEmpty) {
          return const Center(child: Text("데이터 없음"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("입력: ${item?.userInput}"),
                    Text("dist: ${item?.dist}"),
                    Text("ranking: ${item?.ranking}"),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}