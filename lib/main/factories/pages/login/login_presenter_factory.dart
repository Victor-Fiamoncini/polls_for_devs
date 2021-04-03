import 'package:polls_for_devs/main/factories/pages/login/login_validator_factory.dart';
import 'package:polls_for_devs/main/factories/use_cases/authentication_use_case_factory.dart';
import 'package:polls_for_devs/presentation/presenters/getx_login_presenter.dart';
import 'package:polls_for_devs/presentation/presenters/stream_login_presenter.dart';
import 'package:polls_for_devs/ui/pages/login/login_presenter.dart';

LoginPresenter makeStreamLoginPresenter() {
  return StreamLoginPresenter(
    authentication: makeRemoteAuthenticationUseCase(),
    validation: makeLoginValidation(),
  );
}

LoginPresenter makeGetxLoginPresenter() {
  return GetxLoginPresenter(
    authentication: makeRemoteAuthenticationUseCase(),
    validation: makeLoginValidation(),
  );
}
