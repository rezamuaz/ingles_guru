import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sysbit/src/app.dart';
import 'package:sysbit/src/bootstap.dart';
import 'package:sysbit/src/core/local_storage/object_box/store_repository.dart';
import 'package:sysbit/src/core/local_storage/shared_pref/shared_pref.dart';
import 'package:sysbit/src/life_cycle.dart';

import 'src/bloc_observer.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  WidgetsFlutterBinding.ensureInitialized();
  StoreRepository storeRepository = StoreRepository();
  await storeRepository.initStore();
  // Bloc.observer = AppBlocObserver();
  const keyGb = '9sg9YSFuKan44NSc';
  await EncryptedSharedPreferences.initialize(keyGb);
  await SharedPrefs.init();
  await bootstrap(() => LifeCycleManager(
          child: App(
        storeRepository: storeRepository,
      )));
}
