import 'package:aezakmi_test_task/core/extensions/validators_ext.dart';
import 'package:aezakmi_test_task/domain/repositories/auth_repository.dart';
import 'package:mobx/mobx.dart';

part 'register_store.g.dart';

enum RegisterValidationError {
  nameEmpty,
  emailInvalid,
  passwordInvalid,
  confirmEmpty,
  mismatch,
}

class RegisterStore = _RegisterStore with _$RegisterStore;

abstract class _RegisterStore with Store {
  final AuthRepository _authRepository;

  _RegisterStore(this._authRepository);

  @observable
  String name = '';

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  bool isSuccess = false;

  @observable
  RegisterValidationError? validationErrorCode;

  @computed
  bool get isNameValid => name.trim().isNotEmpty;

  @computed
  bool get isEmailValid => email.isEmailValid();

  @computed
  bool get isPasswordValid => password.isPasswordValid();

  @computed
  bool get doPasswordsMatch => password == confirmPassword;

  @computed
  bool get canRegister =>
      isNameValid && isEmailValid && isPasswordValid && doPasswordsMatch && !isLoading;

  @action
  bool validate() {
    if (!isNameValid) {
      validationErrorCode = RegisterValidationError.nameEmpty;
      return false;
    }
    if (!isEmailValid) {
      validationErrorCode = RegisterValidationError.emailInvalid;
      return false;
    }
    if (!isPasswordValid) {
      validationErrorCode = RegisterValidationError.passwordInvalid;
      return false;
    }
    if (confirmPassword.isEmpty) {
      validationErrorCode = RegisterValidationError.confirmEmpty;
      return false;
    }
    if (!doPasswordsMatch) {
      validationErrorCode = RegisterValidationError.mismatch;
      return false;
    }
    validationErrorCode = null;
    return true;
  }

  @action
  void setName(String value) => name = value;

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
  void setConfirmPassword(String value) {
    confirmPassword = value;
    errorMessage = null;
  }

  @action
  Future<void> register() async {
    if (!validate()) return;

    isLoading = true;
    errorMessage = null;
    isSuccess = false;

    try {
      await _authRepository.signUp(email, password, name);
      isSuccess = true;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }
}