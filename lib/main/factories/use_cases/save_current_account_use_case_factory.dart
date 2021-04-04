import 'package:polls_for_devs/data/services/save_current_account_service/local_save_current_account_service.dart';
import 'package:polls_for_devs/domain/use_cases/save_current_account_use_case.dart';
import 'package:polls_for_devs/main/factories/cache/local_storage_adapter_factory.dart';

SaveCurrentAccountUseCase makeLocalSaveCurrentAccountUseCase() {
  return LocalSaveCurrentAccountService(
    saveSecureCacheStorage: makeLocalStorageAdapter(),
  );
}
