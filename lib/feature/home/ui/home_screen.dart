import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:leximatch/core/style/colors.dart';
import 'package:leximatch/core/widget/button/lexi_game_button/lexi_game_button_type.dart';
import 'package:leximatch/feature/home/ui/providers/home_ad_watched_state_provider.dart';
import 'package:leximatch/feature/home/ui/providers/home_monthly_record_state_provider.dart';
import 'package:leximatch/feature/home/ui/providers/home_record_state_provider.dart';
import 'package:leximatch/feature/home/ui/providers/notice_state_provider.dart';
import 'package:leximatch/feature/home/ui/widgets/card/mode_card_frame.dart';
import 'package:leximatch/feature/home/ui/widgets/dialog/month_record_help_dialog.dart';
import 'package:leximatch/feature/home/ui/widgets/dialog/notice_dialog.dart';

import '../../../core/ad/reward_manager.dart';
import '../../../core/router/route_path.dart';
import '../../../core/widget/box.dart';
import '../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../core/widget/toast.dart';
import '../../splash/ui/widgets/dialog/hard_mode_ad_dialog.dart';
import '../domain/model/record_dto.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNotice();
    });
  }

  Future<void> _checkNotice() async {
    try {
      // 공지사항 조회
      final state = await ref.read(noticeNotifierProvider.future);
      final notice = state.notice;


      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      if (notice == null || notice.content == null) return;
      // 공지사항 다이얼로그 표시
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return NoticeDialog(
            content: notice.content!,
            onConfirm: () {
              Navigator.of(dialogContext).pop();
            },
          );
        },
      );
    } catch (e, st) {
      debugPrint('공지사항 조회 실패: $e');
      debugPrintStack(stackTrace: st);
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      showToast("공지사항을 불러오지 못했어요.\n잠시 후 다시 시도해주세요.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const HomeBody(),

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

class GameAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const GameAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        ],
      ),
    );
  }
}
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
      child: SafeArea(
        child: const Column(
          children: [
            GameAppBar(),
            Expanded(
              child: _HomeContent(),
            ),
          ],
        ),
      ),
    );
  }
}
class _HomeContent extends ConsumerWidget {
  const _HomeContent();
  void _showRecordHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => MonthRecordHelpDialog(
        onConfirm: () => Navigator.of(dialogContext).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeRecordNotifierProvider);
    final monthlyRecordState = ref.watch(homeMonthlyRecordNotifierProvider);
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
    final monthlyRecord = monthlyRecordState.valueOrNull;

    final normalRecord = record?.normalRecord;
    final hardRecord = record?.hardRecord;
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsetsGeometry.only(
                  left: 12, right: 12, top: 12, bottom: 0),
              child: LexiMatchBox(
                padding: const EdgeInsets.all(12),
                child: MonthlyScoreBox(
                  score: monthlyRecord?.totalScore ?? 0,
                  rank: monthlyRecord?.rank ?? 0,
                  month: record?.recordDate,
                  onHelpTap: () => _showRecordHelpDialog(context),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: LexiMatchBox(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _TodayHeader(record?.recordDate),

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
                            ? '${normalRecord.elapsedTime}'
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
          // Expanded(
          //   flex: 2,
          //   child: Padding(
          //       padding: const EdgeInsets.all(10), child: _NoticeCard()),
          // ),
        ],
      ),
    );
  }
}

class _TodayHeader extends StatelessWidget {
  final String? recordDate;

  const _TodayHeader(this.recordDate);

  String get formattedDate {
    if (recordDate == null) return '';

    final date = DateTime.parse(recordDate!);

    return '${date.year}년 ${date.month}월 ${date.day}일';
  }

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
        Expanded(
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
                formattedDate,
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

    try {
      final adWatch = await notifier.fetchAdWatch();

      if (!mounted) return;

      if (adWatch == null) {
        showToast('광고 시청 여부를 확인하지 못했습니다.');
        return;
      }

      if (!adWatch.adWatched) {
        _showAdDialog();
        return;
      }

      // 이미 오늘 광고를 시청한 경우
      context.go(RoutePath.hardGame);
    } catch (e, st) {
      debugPrint('광고 시청 여부 조회 실패: $e');
      debugPrintStack(stackTrace: st);

      if (!mounted) return;

      showToast('광고 시청 여부를 확인하지 못했습니다.');
    }
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
      description: '어려운 만큼 보상도 2배!\n다양한 품사의 단어에 도전해보세요!',
      buttonText: '도전하기',
      buttonType: LexiButtonType.hard_mode,
      color: Colors.deepPurple,
      clearRecord:
          widget.hardRecord != null ? '${widget.hardRecord!.elapsedTime}' : '-',
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

class MonthlyScoreBox extends StatelessWidget {
  final int score;
  final int rank;
  final VoidCallback? onHelpTap;
  final String? month;

  const MonthlyScoreBox({
    super.key,
    required this.score,
    required this.rank,
    required this.month,
    this.onHelpTap,
  });
  String get formattedDate {
    if (month == null) return '';

    final date = DateTime.parse(month!);

    return '${date.month}월';
  }
  @override
  Widget build(BuildContext context) {

    final formattedScore = score.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
    );

    return LayoutBuilder(
      builder: (context, c) {
        final h = c.maxHeight.isFinite ? c.maxHeight : 80.0;
        final titleSize = (h * 0.15).clamp(12.0, 18.0).toDouble();
        final labelSize = (h * 0.15).clamp(10.0, 26.0).toDouble();
        final valueSize = (h * 0.20).clamp(12.0, 20.0).toDouble();

        final dotSize = titleSize * 0.4;
        final helpButtonSize = (titleSize * 1.5).clamp(28.0, 40.0).toDouble();

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 헤더: 점 + 제목 (왼쪽) / 도움말 버튼 (오른쪽)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF26B4F),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: titleSize * 0.4),
                    Text(
                      '${formattedDate} 기록',
                      style: TextStyle(
                        fontSize: titleSize,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onHelpTap,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: helpButtonSize,
                    height: helpButtonSize,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3E3C3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.help_outline_rounded,
                      size: helpButtonSize * 0.58,
                      color: const Color(0xFF6B4A1E),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.04),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _StatTile(
                      borderColor: const Color(0xFFFFDFA0),
                      label: 'Point',
                      value: formattedScore,
                      unit: '점',
                      labelSize: labelSize,
                      valueSize: valueSize,
                    ),
                  ),
                  SizedBox(width: h * 0.06),
                  Expanded(
                    child: _StatTile(
                      borderColor: const Color(0xFFBEE0A6),
                      label: 'Rank',
                      value: rank > 0 ? '$rank' : '-',
                      unit: rank > 0 ? '위' : '',
                      labelSize: labelSize,
                      valueSize: valueSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
class _StatTile extends StatelessWidget {
  final Color borderColor;
  final String label;
  final String value;
  final String unit;
  final double labelSize;
  final double valueSize;

  const _StatTile({
    required this.borderColor,
    required this.label,
    required this.value,
    required this.unit,
    required this.labelSize,
    required this.valueSize,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: labelSize,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF6F5F4A),
                ),
              ),
            ],
          ),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: valueSize,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      height: 1.1,
                    ),
                  ),
                  if (unit.isNotEmpty) ...[
                    const SizedBox(width: 3),
                    Text(
                      unit,
                      style: TextStyle(
                        fontSize: valueSize * 0.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
