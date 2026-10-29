import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/home/ui/providers/state/home_monthly_record_notifier.dart';

import '../../domain/model/monthly_record_dto.dart';

final homeMonthlyRecordNotifierProvider = AutoDisposeAsyncNotifierProvider<
    HomeMonthlyRecordNotifier, MonthlyRecordDto>(
  HomeMonthlyRecordNotifier.new,
);
