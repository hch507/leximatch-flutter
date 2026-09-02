import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:leximatch/core/widget/box.dart';
import 'package:leximatch/core/widget/button/lexi_game_button/lexi_game_button_type.dart';
import 'package:leximatch/feature/game/domain/model/hint_dto.dart';
import 'package:leximatch/feature/game/ui/providers/game_state_provider.dart';
import 'package:leximatch/feature/game/ui/providers/hint_state_provider.dart';
import 'package:leximatch/feature/game/ui/providers/initial_hint_state_provider.dart';
import 'package:leximatch/feature/game/ui/providers/opening_hint_state_provider.dart';
import 'package:leximatch/feature/game/ui/providers/state/game_ui_state.dart';
import 'package:leximatch/feature/game/ui/style/hint_result_dialog_style.dart';
import 'package:leximatch/feature/game/ui/widgets/card/research_card.dart';
import 'package:leximatch/feature/game/ui/widgets/card/similarity_progress_card.dart';
import 'package:leximatch/feature/game/ui/widgets/card/top5_result_card.dart';
import 'package:leximatch/feature/game/ui/widgets/dialog/correct_answer_dialog.dart';
import 'package:leximatch/feature/game/ui/widgets/dialog/f_initial_hint_result_dialog.dart';
import 'package:leximatch/feature/game/ui/widgets/dialog/hint_dialog.dart';
import 'package:leximatch/feature/game/ui/widgets/dialog/hint_result_dialog.dart';
import 'package:leximatch/feature/game/ui/widgets/dialog/opening_hint_dialog.dart';
import 'package:leximatch/feature/game/ui/widgets/dialog/s_initial_hint_result_dialog.dart';
import 'package:leximatch/feature/game/ui/widgets/dialog/support_send_dialog.dart';
import 'package:leximatch/feature/game/ui/widgets/textfield/lexi_text_field.dart';

import '../../../core/ad/reward_manager.dart';
import '../../../core/network/exception/api_exception.dart';
import '../../../core/router/route_path.dart';
import '../../../core/style/colors.dart';
import '../../../core/utils/shared_util.dart';
import '../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../core/widget/button/pressable_image_button.dart';
import '../../../core/widget/toast.dart';
import '../domain/model/game_dto.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}
class _GameScreenState extends ConsumerState<GameScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadOpeningHint();
    });
  }

  Future<void> _loadOpeningHint() async {
    try {
      final hint = await ref
          .read(openingHintProvider.notifier)
          .fetchOpeningHint();

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      if (hint == null) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => OpeningHintDialog(
          word: hint.userInput,
          onConfirm: () {
            Navigator.pop(context);
          },
        ),
      );
    } catch (e, st) {
      debugPrint("오프닝 힌트 조회 실패: $e");
      debugPrintStack(stackTrace: st);

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      showToast("힌트를 불러오지 못했어요.\n잠시 후 다시 시도해주세요.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const GameBody(),

          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
// class GameScreen extends StatelessWidget {
//   const GameScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: GameBody(),
//     );
//   }
// }

class GameAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const GameAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  void _showSupportSendDialog(BuildContext context,WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SupportSendDialog(


        onSend: () async {
          debugPrint("onSend");
          final gameState = ref.read(gameStateProvider).value;
          debugPrint(gameState.toString());
          if (gameState == null) return;

          if (gameState.top5.length < 5) {
            showToast("공유할 단어를 5개 이상 입력해주세요.");
            return;
          }

          Navigator.pop(context);

          await ShareUtil.shareTop5(
            top5: gameState.top5,
          );
        },
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/ic_leximatch_new_logo.png',
            height: 40,
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

          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 40,
              height: 40,
              child: PressableImageButton(
                  imagePath: "assets/images/ic_support_send.png",
                  onTap: () {
                    _showSupportSendDialog(context,ref);
                  }),
            ),
          )
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
            GameAppBar(),
            Expanded(
              child: GameFrame(),
            ),
          ],
        ),
      ),
    );
  }
}

class GameFrame extends StatelessWidget {
  const GameFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: LexiMatchBox(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: const [
            Expanded(
              flex: 1,
              child: InputSection(),
            ),
            Expanded(
              flex: 7,
              child: ResultSection(),
            ),
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

        final textFieldHeight = (height! * 0.34).clamp(48.0, 58.0);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LexiTextField(
              controller: _textEditingController,
              onClear: () {
                _textEditingController.clear();
                setState(() {});
              },
              onSearch: () {
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
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _textEditingController.value = TextEditingValue.empty;
                });
              },
              isError: _isInputError,
              height: textFieldHeight,
            ),
            SizedBox(height: height! * 0.03),
          ],
        );
      },
    );
  }
}

class ResultSection extends ConsumerStatefulWidget {
  const ResultSection({super.key});

  @override
  ConsumerState<ResultSection> createState() => _ResultSectionState();
}

class _ResultSectionState extends ConsumerState<ResultSection> {
  double? _baseHeight;

  @override
  Widget build(BuildContext context) {
    _listenCorrectAnswerDialog(context, ref);
    _listenRankingHaptic(ref);

    final asyncState = ref.watch(gameStateProvider);

    final gameState = asyncState.value ?? const GameUiState();

    final myResult = gameState.displayMyResult;

    final top5 = gameState.top5;
    final progressResult = top5.isNotEmpty ? top5.first : null;

    final isWordNotInDictionary = gameState.isWordNotFound;

    final ranking = int.tryParse(myResult.ranking.toString()) ?? 9999;
    final style = HintResultDialogStyle.of(ranking);

    return LayoutBuilder(
      builder: (context, constraints) {
        _baseHeight ??= constraints.maxHeight;

        final height = _baseHeight!;

        final myCardHeight = height * 0.13;

        final resultProgressHeight = height * 0.20;

        final icTitleHeight = myCardHeight * 0.3;

        final hintCardHeight = height * 0.08;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: const Alignment(-0.85, 0),
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
                                color: style.pointColor.withOpacity(
                                  0.32 * animation.value,
                                ),
                                blurRadius: glowAnimation.value,
                                spreadRadius: glowAnimation.value * 0.08,
                              ),

                              // 하얀빛 보조 glow
                              BoxShadow(
                                color: Colors.white.withOpacity(
                                  0.12 * animation.value,
                                ),
                                blurRadius: glowAnimation.value * 0.5,
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
                  input: isWordNotInDictionary ? "-" : myResult.userInput,
                  similarity:
                      isWordNotInDictionary ? "-" : myResult.dist.toString(),
                  rank:
                      isWordNotInDictionary ? "-" : myResult.ranking.toString(),
                  style: style,
                  showSearchIcon: false,
                ),
              ),
            ),
            SizedBox(
              height: 16,
              child: Visibility(
                visible: isWordNotInDictionary,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: const Padding(
                  padding: EdgeInsets.only(
                    left: 18,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '단어를 찾지 못했습니다',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            SimilarityProgressCard(
              word: progressResult?.userInput ?? "-",
              rank: progressResult?.ranking ?? "-",
              height: resultProgressHeight,
            ),
            const SizedBox(height: 5),
            Expanded(
              child: _buildTop5Section(
                isServerError: asyncState.hasError,
                top5: top5,
              ),
            ),
            ResultHintCard(
              height: hintCardHeight,
            ),
          ],
        );
      },
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
        onCancel: () {
          Navigator.pop(context);
        }, onBigHintWatch: _onInitialHintAdWatch, onRandomHintWatch: _onAdWatch,
      ),
    );
  }

  void _onHintTap() {
    _showHintDialog(context);
  }
  Future<void> _onInitialHintAdWatch() async {

    try {
      final hint = await ref.read(initialHintProvider.notifier).fetchInitialHint();

      if (hint == null) {
        showToast("힌트를 불러오지 못했어요");
        return;
      }
      if (!mounted) return;

      Navigator.pop(context);

      _showRewardAd(
        onComplete: () {
          if (hint.isSuccess) {
            _showSuccessInitialHintResultDialog(hint.initial);
          } else {
            _showFailInitialHintResultDialog();
          }
        },
      );

    } catch (e, st) {
      debugPrint("힌트 조회 실패: $e");
      debugPrintStack(stackTrace: st);
      showToast("서버 오류가 발생했습니다.");
    }
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

      _showRewardAd(
        onComplete: () => _showHintResultDialog(hint),
      );

    } catch (e, st) {
      debugPrint("힌트 조회 실패: $e");
      debugPrintStack(stackTrace: st);
      // TODO:
      showToast("서버 오류가 발생했습니다.");
    }
  }
  void _showRewardAd({
    required VoidCallback onComplete,
  }) {
    rewardAdManager.show(
      onRewarded: () {
        debugPrint("광고 시청 완료");

        if (!mounted) return;

        onComplete();
      },
      onLoading: () {
        showToast(
          "광고를 준비중입니다.\n잠시만 기다려주세요.",
        );
      },
      onLoadFailed: () {
        if (!mounted) return;

        onComplete();
      },
      onNotReady: () {
        showToast(
          "광고를 준비중입니다.\n잠시 후 다시 시도해주세요.",
        );
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
  void _showFailInitialHintResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => FInitialHintResultDialog(
        onConfirm: () {
          Navigator.pop(context);
        },
      ),
    );
  }
  void _showSuccessInitialHintResultDialog(String? initial) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SInitialHintResultDialog(
        onConfirm: () {
          Navigator.pop(context);
        }, initialWord: initial!,
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
                '매일 00:00에 정답 단어가 변경돼요!',
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
    final displayRank = currentResult.clearRank == 'RANK_SAVE_FAILED'
        ? '확인 불가'
        : '${currentResult.clearRank}등';
    if (!wasCorrect && isCorrect) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => CorrectAnswerDialog(
          elapsedTime: currentResult.elapsedTime,
          rank: displayRank,
          onConfirm: () {
            Navigator.pop(context);
            context.go(RoutePath.home);
          },
        ),
      );
    }
  });
}

void _listenRankingHaptic(WidgetRef ref) {
  ref.listen(
    gameStateProvider,
    (previous, next) {
      final previousResult = previous?.value?.displayMyResult;
      final nextResult = next.value?.displayMyResult;

      if (nextResult == null) return;

      final previousRanking = int.tryParse(
        previousResult?.ranking.toString() ?? '',
      );

      final nextRanking = int.tryParse(
        nextResult.ranking.toString(),
      );

      if (nextRanking == null) return;

      // 동일한 결과로 리빌드된 경우 진동 방지
      if (previousRanking == nextRanking) return;

      if (nextRanking <= 300) {
        HapticFeedback.heavyImpact();
      }
    },
  );
}
