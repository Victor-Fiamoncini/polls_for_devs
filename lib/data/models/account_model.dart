import 'package:polls_for_devs/data/http/http_error.dart';
import 'package:polls_for_devs/domain/entities/account_entity.dart';

class AccountModel {
  final String accessToken;

  AccountModel(this.accessToken);

  factory AccountModel.fromJson(Map json) {
    if (!json.containsKey('accessToken')) {
      throw HttpError.invalidData;
    }

    return AccountModel(json['accessToken'] as String);
  }

  AccountEntity toEntity() {
    return AccountEntity(accessToken);
  }
}
