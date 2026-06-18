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

CoreServices setupCoreServices() {
  return CoreServices(
    dioClient: DioClient(),
    networkInfo: const NetworkInfoImpl(),
    localStorage: const SecureStorageService(),
  );
}
