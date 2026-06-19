
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leximatch/feature/splash/ui/providers/device_state_provider.dart';
import 'package:leximatch/feature/splash/ui/providers/version_state_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/router/route_path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/widget/toast.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  Future<void> _initialize() async {
    final canEnter = await _checkVersion();

    if (!canEnter) {
      return;
    }

    final deviceRegistered = await _registerDevice();

    if (!deviceRegistered) {
      return;
    }

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    context.go(RoutePath.home);

  }
  Future<bool> _checkVersion() async {
    try {
      final versionState =
      await ref.read(versionNotifierProvider.future);

      final packageInfo = await PackageInfo.fromPlatform();

      final currentVersion = packageInfo.version;
      final minimumVersion = versionState.version?.minVersion;

      if (minimumVersion == null) {
        showToast(
            "서버 오류가 발생 하였습니다 "
        );
        return false;
      }

      final needForceUpdate = _isLowerVersion(
        currentVersion: currentVersion,
        minimumVersion: minimumVersion,
      );

      if (!mounted) return false;

      if (needForceUpdate) {
        _showForceUpdateDialog();
        return false;
      }

      return true;
    } catch (e) {
      debugPrint('버전 체크 실패 : $e');

      if (!mounted) return false;

      showToast(
        "버전 체크 실패 "
      );

      return false;
    }
  }

  Future<bool> _registerDevice() async {
    try {
      await ref
          .read(deviceNotifierProvider.notifier).register();

      return true;
    } catch (e) {
      debugPrint('기기 등록 실패 : $e');
      showToast(
          " '서비스 연결에 실패했습니다.\n잠시 후 다시 시도해주세요.',"
      );
      if (!mounted) return false;

      return false;
    }
  }
  bool _isLowerVersion({
    required String currentVersion,
    required String minimumVersion,
  }) {
    final current =
    currentVersion.split('.').map(int.parse).toList();

    final minimum =
    minimumVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
      if (current[i] < minimum[i]) {
        return true;
      }

      if (current[i] > minimum[i]) {
        return false;
      }
    }

    return false;
  }

  void _showForceUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('업데이트 필요'),
          content: const Text(
                '최신 버전으로 업데이트해주세요.',
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await openStore();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: _SplashBody(),
    );
  }
}

class _SplashBody extends StatelessWidget {
  const _SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Image.asset(
          'assets/images/leximatch_title_logo.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

Future<void> openStore() async {
  final Uri uri;

  if (Platform.isAndroid) {
    uri = Uri.parse(
      'market://details?id=com.lotto.leximatch',
    );
  } else if (Platform.isIOS) {
    uri = Uri.parse(
      'itms-apps://itunes.apple.com/app/id6769692832',
    );
  } else {
    return;
  }

  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('스토어를 열 수 없습니다.');
  }
}
