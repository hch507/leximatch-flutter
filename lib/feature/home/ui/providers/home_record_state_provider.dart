import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/home/ui/providers/state/home_record_notifier.dart';

import '../../domain/model/home_record_dto.dart';

final homeRecordNotifierProvider =
AutoDisposeAsyncNotifierProvider<HomeRecordNotifier, HomeRecordDto>(
  HomeRecordNotifier.new,
);
