import 'package:meta/meta.dart';
import 'package:polls_for_devs/data/http/http_client.dart';
import 'package:polls_for_devs/data/http/http_error.dart';
import 'package:polls_for_devs/data/mappers/remote_authentication_mapper.dart';
import 'package:polls_for_devs/data/models/account_model.dart';
import 'package:polls_for_devs/domain/entities/account_entity.dart';
import 'package:polls_for_devs/domain/helpers/domain_error.dart';
import 'package:polls_for_devs/domain/use_cases/authentication_use_case.dart';

class RemoteAuthenticationService {
  final HttpClient httpClient;
  final String url;

  RemoteAuthenticationService({@required this.httpClient, @required this.url});

  Future<AccountEntity> auth(AuthenticationUseCaseParams params) async {
    final body = RemoteAuthenticationMapper.fromDomain(params).toJson();

    try {
      final httpResponse = await httpClient.request(
        url: url,
        method: 'post',
        body: body,
      );

      return AccountModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (err) {
      throw err == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}
