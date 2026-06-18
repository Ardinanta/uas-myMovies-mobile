import 'package:get_it/get_it.dart';

import 'network/dio_client.dart';
import 'network/network_info.dart';
import 'storage/local_storage_service.dart';
import 'storage/secure_storage_service.dart';

class CoreServices {
  const CoreServices({
    required this.dioClient,
    required this.networkInfo,
    required this.localStorage,
  });

  final DioClient dioClient;
  final NetworkInfo networkInfo;
  final LocalStorageService localStorage;
}

final coreSl = GetIt.instance;

void setupCoreServicesDependencies({GetIt? getIt}) {
  final sl = getIt ?? coreSl;

  if (!sl.isRegistered<LocalStorageService>()) {
    sl.registerLazySingleton<LocalStorageService>(
      () => const SecureStorageService(),
    );
  }

  if (!sl.isRegistered<NetworkInfo>()) {
    sl.registerLazySingleton<NetworkInfo>(() => const NetworkInfoImpl());
  }

  if (!sl.isRegistered<DioClient>()) {
    sl.registerLazySingleton<DioClient>(
      () => DioClient(storageService: sl<LocalStorageService>()),
    );
  }
}

CoreServices setupCoreServices() {
  setupCoreServicesDependencies();

  return CoreServices(
    dioClient: coreSl<DioClient>(),
    networkInfo: coreSl<NetworkInfo>(),
    localStorage: coreSl<LocalStorageService>(),
  );
}
