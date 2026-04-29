import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/core/widget/box.dart';
import 'package:leximatch/feature/game/data/dto/game_dto.dart';
import 'package:leximatch/feature/game/ui/providers/game_state_provider.dart';

import '../../../core/style/colors.dart';
import '../../../core/widget/button.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: const GameAppBar(),
      body: GameBody(),
    );
  }
}

class GameAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GameAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/leximatch_title_logo.png',
              height: 70,
              fit: BoxFit.contain,
            ),

            // 왼쪽 버튼
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: PressableImageButton(
                  imagePath: "assets/images/ic_home.png",
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameBody extends StatelessWidget {
  const GameBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/game_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: InputSection(),
          ),
          SizedBox(height: 12),
          Expanded(
            flex: 6,
            child: ResultSection(),
          )
        ],
      ),
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
  void initState() {
    super.initState();

    _textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: LexiMatchBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LexiTextField(
                controller: _textEditingController,
                onClear: () {
                  _textEditingController.clear();
                  setState(() {});
                },
              ),
              SizedBox(height: 16),
              LexiGameButton(
                text: "유사도 체크",
                width: 150,
                height: 50,
                onTap: () {
                  ref
                      .read(gameStateProvider.notifier)
                      .fetchSimilarity(_textEditingController.text);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ResultSection extends ConsumerWidget {
  const ResultSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameStateProvider);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: LexiMatchBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: state.when(
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

                      return _ResultCard(
                        item: item,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final GameDto? item;

  const _ResultCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
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
  }
}

class LexiTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onClear;

  const LexiTextField({
    super.key,
    required this.controller,
    this.hintText = "단어 입력",
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: 1,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            "assets/images/ic_paw.png",
            width: 30,
            height: 30,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: onClear,
          child: const Icon(
            Icons.cancel,
            size: 24,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFFB8B0AA),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.8,
          ),
        ),
      ),
    );
  }
}
