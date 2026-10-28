import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/button/lexi_game_button/lexi_game_button.dart';
import '../../../../../core/widget/dialog.dart';

class NoticeDialog extends StatefulWidget {
  final String content;     // 서버에서 받은 공지 본문
  final VoidCallback onConfirm;

  const NoticeDialog({
    super.key,
    required this.content,
    required this.onConfirm,
  });

  @override
  State<NoticeDialog> createState() => _NoticeDialogState();
}

class _NoticeDialogState extends State<NoticeDialog> {
  static const _ink = Color(0xFF3B2F1E);
  static const _body = Color(0xFF6F5F4A);


  @override
  Widget build(BuildContext context) {
    final maxBoxHeight = MediaQuery.sizeOf(context).height * 0.4;

    return LexiDialog(
      borderColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 아이콘
          Row(
            children: [
              // 아이콘
              Image.asset(
                'assets/images/ic_notice_lodo.png',
                height: 30,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12),
              const Text(
                '공지사항',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: _ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 하얀 박스: 서버 내용이 들어가는 곳 (길면 스크롤)
          Container(
            width: double.infinity,
            height: 200,
            constraints: BoxConstraints(maxHeight: maxBoxHeight),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 8),
                    Text(
                      widget.content,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: _body,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),


          LexiGameButton(
            text: '확인',
            width: double.infinity,
            height: 40,
            onTap: widget.onConfirm,
          ),
        ],
      ),
    );
  }
}