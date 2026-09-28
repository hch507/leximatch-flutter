import 'package:flutter/material.dart';

import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/button/lexi_game_button/lexi_game_button_type.dart';


class ModeCardFrame extends StatelessWidget {
  const ModeCardFrame({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.buttonType,
    required this.onTap,
    required this.color,
    required this.clearRecord,

    required this.rank,
    this.locked = false,
    this.lockMessage,
  });

  final Widget icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onTap;
  final Color color;
  final String clearRecord;
  final LexiButtonType buttonType;
  final String rank;
  final bool locked;
  final String? lockMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        icon,

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                              Text(
                                description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    border: Border(
                      top: BorderSide(
                        color: color.withOpacity(0.12),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _RecordItem(
                          icon: Image.asset(
                            'assets/images/ic_timer.png',
                            fit: BoxFit.contain,
                          ),
                          title: '클리어 기록',
                          value: clearRecord,
                        ),
                      ),

                      Container(
                        width: 1,
                        height: 36,
                        color: Colors.grey.withOpacity(0.2),
                      ),

                      Expanded(
                        child: _RecordItem(
                          icon: Image.asset(
                            'assets/images/ic_trophy.png',
                            fit: BoxFit.contain,
                          ),
                          title: '최초 클리어 랭크',
                          value: rank,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: Center(
                    child: LexiGameButton(
                      text: buttonText,
                      type: buttonType,
                      height: 40,
                      onTap: onTap,
                    ),
                  ),
                ),
              ],
            ),

            if (locked)
              Positioned.fill(
                child: _LockOverlay(
                  message: lockMessage ?? '노말 모드를 클리어하면\n도전할 수 있어요!',
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LockOverlay extends StatelessWidget {
  const _LockOverlay({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey.withOpacity(0.65),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lock,
              size: 48,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecordItem extends StatelessWidget {
  const _RecordItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  final Widget icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 5,),
        SizedBox(
          width: 30,
          height: 30,
          child: icon,
        ),
        const SizedBox(width: 5),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}