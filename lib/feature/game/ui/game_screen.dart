import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:leximatch/core/widget/box.dart';
import 'package:leximatch/feature/game/data/dto/game_dto.dart';
import 'package:leximatch/feature/game/ui/providers/game_state_provider.dart';
import 'package:leximatch/feature/game/ui/providers/state/game_ui_state.dart';
import 'package:leximatch/feature/game/ui/widgets/card/research_card.dart';
import 'package:leximatch/feature/game/ui/widgets/card/top5_result_card.dart';
import 'package:leximatch/feature/game/ui/widgets/dialog/correct_answer_dialog.dart';

import '../../../core/router/route_path.dart';
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
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Colors.black.withOpacity(0.55),
                      builder: (_) => CorrectAnswerDialog(
                        elapsedTime: '00:23',
                        onConfirm: () {
                          context.go(RoutePath.home);
                        },
                      ),
                    );
                  },
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
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: LexiMatchBox(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: LexiGameButton(
                      text: "유사도 체크",
                      width: 150,
                      height: 50,
                      onTap: () {
                        ref
                            .read(gameStateProvider.notifier)
                            .fetchSimilarity(_textEditingController.text);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          "assets/images/ic_lodo_search.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
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
    final asyncState = ref.watch(gameStateProvider);

    final gameState = asyncState.value ?? const GameUiState();
    final myResult = gameState.displayMyResult;
    final top5 = gameState.top5;

    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      child: LexiMatchBox(
        padding: const EdgeInsets.fromLTRB(12, 10, 12,10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: const Alignment(-0.9, 0), // 시작점에서 약 10% 안쪽
              child: Image.asset(
                'assets/images/ic_my_research_title.png',
                height: 30,
              ),
            ),
            MySearchResultCard(
              input: myResult.userInput,
              similarity: myResult.dist.toString(),
              rank: myResult.ranking.toString(),
            ),
            const Divider(
              height: 24,
              thickness: 1.2,
              color: Color(0xFFE3D7BE),
              indent: 18,
              endIndent: 18,
            ),
            Expanded(
              child: Column(
                children: List.generate(5, (index) {
                  final hasItem = index < top5.length;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: hasItem
                          ? Top5ResultCard(
                        item: top5[index],
                        rank: index + 1,
                      )
                          : const SizedBox.expand(),
                    ),
                  );
                }),
              ),
            ),
            ResultHintCard()
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


class ResultHintCard extends StatelessWidget {

  const ResultHintCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFAED),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFEFD8A8),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/ic_hint.png',
            width: 28,
            height: 28,
          ),

          const SizedBox(width: 10),

          const Expanded(
            child: Text(
              '매일 정각 정답 단어가 변경되요!',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A3A2A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}