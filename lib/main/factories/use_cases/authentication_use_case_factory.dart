import 'package:polls_for_devs/data/services/remote_authentication_service.dart';
import 'package:polls_for_devs/domain/use_cases/authentication_use_case.dart';
import 'package:polls_for_devs/main/factories/http/api_url_factory.dart';
import 'package:polls_for_devs/main/factories/http/http_client_factory.dart';

AuthenticationUseCase makeRemoteAuthenticationUseCase() {
  return RemoteAuthenticationService(
    httpClient: makeHttpAdapter(),
    url: makeApiUrl('login'),
  );
}
