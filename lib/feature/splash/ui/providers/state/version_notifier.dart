import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leximatch/feature/splash/domain/providers/version_respository_provider.dart';
import 'package:leximatch/feature/splash/domain/repository/version_repository.dart';
import 'package:leximatch/feature/splash/ui/providers/state/version_ui_state.dart';

import '../../../domain/providers/device_repository_provider.dart';
import '../../../domain/repository/device_repository.dart';

class VersionNotifier extends AutoDisposeAsyncNotifier<VersionUiState> {
  late final VersionRepository _repository =
      ref.read(versionRepositoryProvider);

  @override
  Future<VersionUiState> build() async {


    final version = await _repository.fetchVersion();

    return VersionUiState(
      version: version,
    );
  }



}
