import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/splash/ui/providers/state/device_notifier.dart';

final deviceNotifierProvider =
AutoDisposeAsyncNotifierProvider<DeviceNotifier, void>(
  DeviceNotifier.new,
);
