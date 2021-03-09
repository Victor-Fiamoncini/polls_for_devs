import 'package:polls_for_devs/domain/entities/account_entity.dart';

class AccountModel {
  final String accessToken;

  AccountModel(this.accessToken);

  factory AccountModel.fromJson(Map json) {
    return AccountModel(json['accessToken'] as String);
  }

  AccountEntity toEntity() {
    return AccountEntity(accessToken);
  }
}
