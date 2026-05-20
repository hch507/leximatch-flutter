import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:leximatch/core/widget/box.dart';
import 'package:leximatch/core/widget/button/lexi_game_button/lexi_game_button_type.dart';
import 'package:leximatch/feature/game/domain/model/hint_dto.dart';
import 'package:leximatch/feature/game/ui/providers/game_state_provider.dart';
import 'package:leximatch/feature/game/ui/providers/hint_state_provider.dart';
import 'package:leximatch/feature/game/ui/providers/state/game_ui_state.dart';
import 'package:leximatch/feature/game/ui/widgets/card/research_card.dart';
import 'package:leximatch/feature/game/ui/widgets/card/top5_result_card.dart';
import 'package:leximatch/feature/game/ui/widgets/dialog/correct_answer_dialog.dart';
import 'package:leximatch/feature/game/ui/widgets/dialog/hint_dialog.dart';
import 'package:leximatch/feature/game/ui/widgets/dialog/hint_result_dialog.dart';

import '../../../core/ad/reward_manager.dart';
import '../../../core/network/exception/api_exception.dart';
import '../../../core/router/route_path.dart';
import '../../../core/style/colors.dart';
import '../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../core/widget/button/pressable_image_button.dart';
import '../../../core/widget/toast.dart';
import '../domain/model/game_dto.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GameBody(),
    );
  }
}

class GameAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GameAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
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
            child: SizedBox(
              width: 40,
              height: 40,
              child: PressableImageButton(
                imagePath: "assets/images/ic_home.png",
                onTap: () {
                  context.go(RoutePath.home);
                },
              ),
            ),
          ),
        ],
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
      child: SafeArea(
        child: const Column(
          children: [
            // 직접 넣기
            GameAppBar(),
            Expanded(
              flex: 2,
              child: InputSection(),
            ),
            SizedBox(height: 5),
            Expanded(
              flex: 6,
              child: ResultSection(),
            )
          ],
        ),
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

  bool _isInputError = false;
  double? height;
  double? width;
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
    return LayoutBuilder(
      builder: (context, constraints) {

        width = constraints.maxWidth;
        height = constraints.maxHeight;

        final buttonWidth = width! * 0.42;
        final buttonHeight = height! * 0.30;

        final dogHeight = height! * 0.55;
        final textFieldHeight = (height! * 0.34).clamp(48.0, 58.0);
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width! * 0.04,
          ),
          child: LexiMatchBox(
            padding: EdgeInsets.fromLTRB(
              width! * 0.03,
              height! * 0.03,
              width! * 0.03,
              0,
            ),
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
                  isError: _isInputError,
                  height: textFieldHeight,
                ),
                SizedBox(height: height! * 0.03),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LexiGameButton(
                      text: "유사도 체크",
                      width: buttonWidth,
                      height: buttonHeight,
                      onTap: () {
                        final text = _textEditingController.text.trim();

                        if (text.isEmpty) {
                          setState(() {
                            _isInputError = true;
                          });
                          return;
                        }

                        setState(() {
                          _isInputError = false;
                        });

                        ref
                            .read(
                              gameStateProvider.notifier,
                            )
                            .fetchSimilarity(text);
                      },
                    ),
                    SizedBox(width: width! * 0.03),
                    Expanded(
                      child: SizedBox(
                        height: dogHeight,
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
class ResultSection extends ConsumerStatefulWidget {
  const ResultSection({super.key});

  @override
  ConsumerState<ResultSection> createState() =>
      _ResultSectionState();
}

class _ResultSectionState
    extends ConsumerState<ResultSection> {

  double? _baseHeight;

  @override
  Widget build(BuildContext context) {

    _listenCorrectAnswerDialog(context, ref);

    final asyncState =
    ref.watch(gameStateProvider);

    final gameState =
        asyncState.value ?? const GameUiState();

    final myResult =
        gameState.displayMyResult;

    final top5 = gameState.top5;

    final isWordNotInDictionary =
        gameState.isWordNotFound;

    return LayoutBuilder(
      builder: (context, constraints) {

        // 최초 높이 저장
        _baseHeight ??=
            constraints.maxHeight;

        final height = _baseHeight!;

        final myCardHeight =
            height * 0.13;

        final icTitleHeight =
            myCardHeight * 0.3;

        final hintCardHeight =
            height * 0.08;

        return Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.viewPaddingOf(context).bottom + 12,
          ),
          child: LexiMatchBox(
            padding:
            const EdgeInsets.fromLTRB(
              12,
              10,
              12,
              10,
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Align(
                  alignment:
                  const Alignment(-0.85, 0),
                  child: Image.asset(
                    'assets/images/ic_my_research_title.png',
                    height: icTitleHeight,
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 360),

                  transitionBuilder: (child, animation) {

                    final scaleAnimation = Tween<double>(
                      begin: 0.92,
                      end: 1.0,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutBack,
                      ),
                    );

                    final glowAnimation = Tween<double>(
                      begin: 0,
                      end: 22,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOut,
                      ),
                    );

                    return AnimatedBuilder(
                      animation: animation,

                      builder: (context, childWidget) {

                        return FadeTransition(
                          opacity: animation,

                          child: Transform.scale(
                            scale: scaleAnimation.value,

                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),

                                boxShadow: [

                                  // 메인 블루 glow
                                  BoxShadow(
                                    color: const Color(0xFF7DD8FF)
                                        .withOpacity(
                                      0.32 * animation.value,
                                    ),

                                    blurRadius: glowAnimation.value,

                                    spreadRadius:
                                    glowAnimation.value * 0.08,
                                  ),

                                  // 하얀빛 보조 glow
                                  BoxShadow(
                                    color: Colors.white.withOpacity(
                                      0.12 * animation.value,
                                    ),

                                    blurRadius:
                                    glowAnimation.value * 0.5,
                                  ),
                                ],
                              ),

                              child: childWidget,
                            ),
                          ),
                        );
                      },

                      child: child,
                    );
                  },

                  child: SizedBox(
                    key: ValueKey(
                      isWordNotInDictionary
                          ? 'not-found'
                          : '${myResult.userInput}_${myResult.ranking}_${myResult.dist}',
                    ),

                    height: myCardHeight,

                    child: MySearchResultCard(
                      input:
                      isWordNotInDictionary
                          ? "-"
                          : myResult.userInput,

                      similarity:
                      isWordNotInDictionary
                          ? "-"
                          : myResult.dist.toString(),

                      rank:
                      isWordNotInDictionary
                          ? "-"
                          : myResult.ranking.toString(),
                    ),
                  ),
                ),

                SizedBox(
                  height: 16,
                  child: Visibility(
                    visible:
                    isWordNotInDictionary,
                    maintainSize: true,
                    maintainAnimation:
                    true,
                    maintainState: true,
                    child: const Padding(
                      padding:
                      EdgeInsets.only(
                        left: 18,
                      ),
                      child: Align(
                        alignment:
                        Alignment
                            .centerLeft,
                        child: Text(
                          '단어를 찾지 못했습니다',
                          style: TextStyle(
                            color:
                            Colors.red,
                            fontSize: 10,
                            fontWeight:
                            FontWeight
                                .w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const Divider(
                  height: 24,
                  thickness: 1.2,
                  color:
                  Color(0xFFE3D7BE),
                  indent: 18,
                  endIndent: 18,
                ),

                Expanded(
                  child: _buildTop5Section(
                    isServerError:
                    asyncState.hasError,
                    top5: top5,
                  ),
                ),

                ResultHintCard(
                  height: hintCardHeight,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LexiTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onClear;
  final bool isError;
  final double height;

  const LexiTextField({
    super.key,
    required this.controller,
    required this.height,
    this.hintText = "단어 입력",
    this.onClear,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = (height * 0.32);
    final iconSize = (height * 0.42);
    final verticalPadding = (height * 0.22);

    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              "assets/images/ic_paw.png",
              width: iconSize,
              height: iconSize,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: onClear,
            child: Icon(
              Icons.cancel,
              size: iconSize,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: verticalPadding,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isError ? Colors.red : const Color(0xFFB8B0AA),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: isError ? Colors.red : AppColors.primary,
              width: 1.8,
            ),
          ),
        ),
      ),
    );
  }
}

class ResultHintCard extends ConsumerStatefulWidget {
  final double height;

  const ResultHintCard({
    super.key,
    required this.height,
  });

  @override
  ConsumerState<ResultHintCard> createState() => _ResultHintCardState();
}

class _ResultHintCardState extends ConsumerState<ResultHintCard> {
  late final RewardAdManager rewardAdManager;

  @override
  void initState() {
    super.initState();
    rewardAdManager = RewardAdManager();
    rewardAdManager.load();
  }

  @override
  void dispose() {
    rewardAdManager.dispose();
    super.dispose();
  }

  void _showHintDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => HintDialog(
        onAdWatch: _onAdWatch,
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _onHintTap() {
    _showHintDialog(context);
  }

  Future<void> _onAdWatch() async {
    debugPrint("_onAdWatch 시작");
    try {
      final hint = await ref.read(hintProvider.notifier).fetchHint();

      if (hint == null) {
        debugPrint("힌트를 불러오지 못했어요");
        return;
      }
      if (!mounted) return;

      Navigator.pop(context);

      _showRewardAd(hint);
    } catch (e, st) {
      debugPrint("힌트 조회 실패: $e");
      debugPrintStack(stackTrace: st);
      // TODO:
      showToast("서버 오류가 발생했습니다.");
    }
  }

  void _showRewardAd(HintDto hint) {
    rewardAdManager.show(
      onRewarded: () {
        debugPrint("광고 시청 완료");

        if (!mounted) return;

        _showHintResultDialog(hint);
      },
      onNotReady: () {
        debugPrint("광고 준비 안됨");
      },
      onFailedToShow: () {
        debugPrint("광고 표시 실패");
        showToast("광고 로드에 실패했습니다.");
      },
    );
  }

  void _showHintResultDialog(HintDto hint) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => HintResultDialog(
        word: hint.userInput.toString(),
        similarity: hint.dist.toString(),
        ranking: hint.ranking.toString(),
        onConfirm: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.height;

    final iconSize = (height * 0.35).clamp(14.0, 20.0);
    final fontSize = (height * 0.24).clamp(10.0, 13.0);
    final buttonWidth = (height * 1.35).clamp(50.0, 70.0);
    final buttonHeight = (height * 0.6).clamp(16.0, 24.0);

    return SizedBox(
      height: height,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: height * 0.30,
          vertical: height * 0.10,
        ),
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
              width: iconSize,
              height: iconSize,
            ),
            SizedBox(width: height * 0.22),
            Expanded(
              child: Text(
                '매일 정각 정답 단어가 변경돼요!',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4A3A2A),
                ),
              ),
            ),
            LexiGameButton(
              text: "힌트",
              useShadow: false,
              type: LexiButtonType.blue,
              width: buttonWidth,
              height: buttonHeight,
              onTap: _onHintTap,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTop5Section({
  required bool isServerError,
  required List<GameDto> top5,
}) {
  if (isServerError) {
    return _buildServerError();
  }

  if (top5.isEmpty) {
    return _buildEmptyTop5();
  }

  return _buildTop5List(top5);
}

Widget _buildServerError() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/server_error_lodo.png', // 네가 넣을 이미지 경로
          width: 150,
        ),
        const SizedBox(height: 12),
        const Text(
          "서버 오류가 발생했습니다",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.red,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "잠시 후 다시 시도해주세요",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildEmptyTop5() {
  return const Center(
    child: Text(
      "최근 검색어가 없습니다",
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    ),
  );
}

Widget _buildTop5List(List<GameDto> top5) {
  return Column(
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
  );
}

void _listenCorrectAnswerDialog(BuildContext context, WidgetRef ref) {
  ref.listen<AsyncValue<GameUiState>>(gameStateProvider, (prev, next) {
    final previousResult = prev?.valueOrNull?.displayMyResult;
    final currentResult = next.valueOrNull?.displayMyResult;

    if (currentResult == null) return;

    final wasCorrect = previousResult?.dist.toString() == '100.0';
    final isCorrect = currentResult.dist.toString() == '100.0';
    if (!wasCorrect && isCorrect) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => CorrectAnswerDialog(
          elapsedTime: currentResult.elapsedTime,
          onConfirm: () {
            Navigator.pop(context);
            context.go(RoutePath.home);
          },
        ),
      );
    }
  });
}
