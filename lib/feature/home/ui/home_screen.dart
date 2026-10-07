import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:leximatch/core/widget/button/lexi_game_button/lexi_game_button_type.dart';
import 'package:leximatch/feature/home/ui/providers/home_ad_watched_state_provider.dart';
import 'package:leximatch/feature/home/ui/providers/home_record_state_provider.dart';
import 'package:leximatch/feature/home/ui/providers/notice_state_provider.dart';
import 'package:leximatch/feature/home/ui/widgets/card/mode_card_frame.dart';

import '../../../core/ad/reward_manager.dart';
import '../../../core/router/route_path.dart';
import '../../../core/widget/box.dart';
import '../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../core/widget/toast.dart';
import '../../splash/ui/widgets/dialog/hard_mode_ad_dialog.dart';
import '../domain/model/record_dto.dart';

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
      child: _HomeContent(),
    );
  }
}

class _HomeContent extends ConsumerWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeRecordNotifierProvider);

    // 에러 발생 시 Toast
    ref.listen(homeRecordNotifierProvider, (previous, next) {
      if (next.hasError && previous?.hasError != true) {
        showToast(
          '기록을 불러오지 못했습니다.',
        );
      }
    });

    // loading / error → null
    // data → HomeRecordDto
    final record = state.valueOrNull;

    final normalRecord = record?.normalRecord;
    final hardRecord = record?.hardRecord;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset(
                  'assets/images/ic_leximatch_new_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: LexiMatchBox(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const _TodayHeader(),

                    const SizedBox(height: 5),

                    // Normal Mode
                    Expanded(
                      child: ModeCardFrame(
                        icon: Image.asset(
                          'assets/images/ic_normal.png',
                          width: 50,
                          height: 50,
                        ),
                        title: '노말 모드',
                        description: '오늘의 단어를 찾아보세요!',
                        buttonText: '시작하기',
                        buttonType: LexiButtonType.normal_mode,
                        color: Colors.green,
                        isCleared: normalRecord != null,
                        clearRecord: normalRecord != null
                            ? '${normalRecord.elapsedTime}초'
                            : '-',
                        rank: normalRecord != null
                            ? '${normalRecord.rank}등'
                            : '-',
                        onTap: () {
                          context.go(RoutePath.game);
                        },
                      ),
                    ),

                    const SizedBox(height: 5),
                    Expanded(
                      child: HardModeCard(
                        hardRecord: hardRecord,
                        normalRecord: normalRecord,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: _NoticeCard()
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayHeader extends StatelessWidget {
  const _TodayHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.calendar_month,
          size: 30,
          color: Colors.blue,
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '오늘의 모맨틀',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '2026년 9월 22일 (화)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HardModeCard extends ConsumerStatefulWidget {
  final RecordDto? normalRecord;
  final RecordDto? hardRecord;

  const HardModeCard({
    super.key,
    required this.normalRecord,
    required this.hardRecord,
  });

  @override
  ConsumerState<HardModeCard> createState() => _HardModeCardState();
}

class _HardModeCardState extends ConsumerState<HardModeCard> {
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

  Future<void> _onTap() async {
    final notifier = ref.read(
      homeAdWatchedNotifierProvider.notifier,
    );

    await notifier.fetchAdWatch();

    final state = ref.read(
      homeAdWatchedNotifierProvider,
    );

    state.when(
      loading: () {
        // fetchAdWatch() 완료 후에는 일반적으로 호출되지 않음
      },
      error: (error, stackTrace) {
        showToast(
          '광고 시청 여부를 확인하지 못했습니다.',
        );
      },
      data: (data) {
        if (data.adWatch?.watched != true) {
          _showAdDialog();
          return;
        }

        // 이미 오늘 광고를 시청한 경우
        context.go(RoutePath.hardGame);
      },
    );
  }

  void _showAdDialog() {
    showDialog(
      context: context,
      builder: (_) => HardModeAdDialog(
        onCancel: () {
          Navigator.pop(context);
        },
        onConfirm: () {
          Navigator.pop(context);
          _showRewardAd();
        },
      ),
    );
  }

  void _showRewardAd() {
    rewardAdManager.show(
      onRewarded: () async {
        debugPrint('하드 모드 광고 시청 완료');

        try {
          await ref.read(homeAdWatchedNotifierProvider.notifier).saveAdWatch();

          if (!mounted) return;

          context.go(RoutePath.hardGame);
        } catch (e, stackTrace) {
          debugPrint('광고 시청 기록 저장 실패: $e');
          debugPrintStack(stackTrace: stackTrace);

          if (!mounted) return;

          showToast(
            '광고 시청 처리에 실패했습니다.',
          );
        }
      },
      onLoading: () {
        showToast(
          '광고를 준비중입니다.\n잠시만 기다려주세요.',
        );
      },
      onLoadFailed: () {
        showToast(
          '광고를 불러오지 못했습니다.\n잠시 후 다시 시도해주세요.',
        );
      },
      onNotReady: () {
        showToast(
          '광고를 준비중입니다.\n잠시 후 다시 시도해주세요.',
        );
      },
      onFailedToShow: () {
        showToast(
          '광고 표시에 실패했습니다.',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModeCardFrame(
      icon: Image.asset(
        'assets/images/ic_hard.png',
        width: 50,
        height: 50,
      ),
      title: '하드 모드',
      isCleared: widget.hardRecord != null,
      description: '다양한 품사의 단어에 도전해보세요!',
      buttonText: '도전하기',
      buttonType: LexiButtonType.hard_mode,
      color: Colors.deepPurple,
      clearRecord: widget.hardRecord != null
          ? '${widget.hardRecord!.elapsedTime}초'
          : '-',
      rank: widget.hardRecord != null ? '${widget.hardRecord!.rank}등' : '-',
      locked: widget.normalRecord == null,
      lockMessage: '노말 모드를 클리어하면\n도전할 수 있어요!',
      onTap: _onTap,
    );
  }
}
class _NoticeCard extends ConsumerWidget {
  const _NoticeCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(noticeNotifierProvider);
    final notice = state.valueOrNull;

    return LexiMatchBox(
      color: const Color(0xFFE8F0D8),
      borderColor: const Color(0xFFC9DDB0),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              'assets/images/ic_notice_lodo.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '오늘의 메시지',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F9B35),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  notice?.notice?.content ?? '오늘도 모맨틀에\n도전해보세요!',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                    color: Color(0xFF60483A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}