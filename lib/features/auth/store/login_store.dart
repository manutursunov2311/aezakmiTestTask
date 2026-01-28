import 'package:aezakmi_test_task/core/extensions/validators_ext.dart';
import 'package:aezakmi_test_task/domain/repositories/auth_repository.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

enum LoginValidationError {
  emailEmpty,
  emailInvalid,
  passwordEmpty,
  passwordInvalid,
}

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final AuthRepository _authRepository;

  _LoginStore(this._authRepository);

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String? errorMessage;

  @observable
  LoginValidationError? validationErrorCode;

  @observable
  bool isSuccess = false;

  @computed
  bool get isEmailValid => email.isEmailValid();

  @computed
  bool get isPasswordValid => password.isPasswordValid();

  @observable
  bool isLoading = false;

  @action
  bool validate() {
    if (email.isEmpty) {
      validationErrorCode = LoginValidationError.emailEmpty;
      return false;
    }
    if (!isEmailValid) {
      validationErrorCode = LoginValidationError.emailInvalid;
      return false;
    }
    if (password.isEmpty) {
      validationErrorCode = LoginValidationError.passwordEmpty;
      return false;
    }
    if (!isPasswordValid) {
      validationErrorCode = LoginValidationError.passwordInvalid;
      return false;
    }
    validationErrorCode = null;
    return true;
  }

  @action
  void setEmail(String value) {
    email = value;
    errorMessage = null;
  }

  @action
  void setPassword(String value) {
    password = value;
    errorMessage = null;
  }

  @action
  Future<void> login() async {
    if (!validate()) return;

    isLoading = true;
    errorMessage = null;
    isSuccess = false;

    try {
      await _authRepository.signIn(email, password);
      isLoading = false;
      isSuccess = true;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}