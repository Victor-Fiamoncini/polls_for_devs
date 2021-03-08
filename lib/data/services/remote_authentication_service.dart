import 'package:meta/meta.dart';
import 'package:polls_for_devs/data/http/http_client.dart';
import 'package:polls_for_devs/domain/use_cases/authentication_use_case.dart';

class RemoteAuthenticationService {
  final HttpClient httpClient;
  final String url;

  RemoteAuthenticationService({@required this.httpClient, @required this.url});

  Future<void> auth(AuthenticationUseCaseParams params) async {
    await httpClient.request(url: url, method: 'post', body: params.toJson());
  }
}
