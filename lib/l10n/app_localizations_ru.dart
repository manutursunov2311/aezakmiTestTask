// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get errorTitle => 'Ошибка';

  @override
  String get ok => 'OK';

  @override
  String get loginTitle => 'Вход';

  @override
  String get registerTitle => 'Регистрация';

  @override
  String get loginButton => 'Войти';

  @override
  String get registerButton => 'Зарегистрироваться';

  @override
  String get labelEmail => 'e-mail';

  @override
  String get phEmailLogin => 'Введите электронную почту';

  @override
  String get phEmailRegister => 'Ваша электронная почта';

  @override
  String get labelPassword => 'Пароль';

  @override
  String get phPasswordLogin => 'Введите пароль';

  @override
  String get phPasswordRegister => '8-16 символов';

  @override
  String get labelName => 'Имя';

  @override
  String get phName => 'Введите ваше имя';

  @override
  String get labelConfirmPassword => 'Подтверждение пароля';

  @override
  String get phConfirmPassword => '8-16 символов';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get justNow => 'только что';

  @override
  String minutesAgo(Object minutes) {
    return '$minutes мин назад';
  }

  @override
  String hoursAgo(Object hours) {
    return '$hours ч назад';
  }

  @override
  String daysAgo(Object days) {
    return '$days д назад';
  }

  @override
  String get valEmailEmpty => 'Пожалуйста, введите email.';

  @override
  String get valEmailInvalid => 'Некорректный формат email.';

  @override
  String get valPasswordEmpty => 'Пожалуйста, введите пароль.';

  @override
  String get valPasswordInvalid =>
      'Пароль должен содержать минимум 8 символов.';

  @override
  String get valNameEmpty => 'Пожалуйста, введите имя.';

  @override
  String get valConfirmPasswordEmpty => 'Пожалуйста, подтвердите пароль.';

  @override
  String get valPasswordsMismatch => 'Пароли не совпадают.';

  @override
  String get errorNotAuthorized => 'Пользователь не авторизован';

  @override
  String errorDelete(Object error) {
    return 'Ошибка удаления изображения: $error';
  }

  @override
  String get galleryTitle => 'Галерея';

  @override
  String get create => 'Создать';

  @override
  String get galleryEmptyTitle => 'Галерея пуста';

  @override
  String get galleryEmptySubtitle => 'Создайте свой первый рисунок';

  @override
  String get deleteImageTitle => 'Удалить изображение?';

  @override
  String deleteImageBody(Object name) {
    return 'Вы уверены, что хотите удалить \"$name\"?';
  }

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get logoutTitle => 'Выход';

  @override
  String get logoutBody => 'Вы уверены, что хотите выйти?';

  @override
  String get logout => 'Выйти';

  @override
  String get errorLoadImages => 'Ошибка загрузки изображений';

  @override
  String get errorDeleteImage => 'Ошибка удаления изображения';

  @override
  String get errorLogout => 'Ошибка выхода';

  @override
  String get successTitle => 'Успешно';

  @override
  String get painterNewTitle => 'Новое изображение';

  @override
  String get painterEditTitle => 'Редактирование';

  @override
  String get colorPickerTitle => 'Выбор цвета';

  @override
  String get painterShareSuccess => 'Рисунок успешно отправлен';

  @override
  String get painterShareDismissed => 'Меню экспорта закрыто';

  @override
  String get painterSaveCreated => 'Новый рисунок создан!';

  @override
  String get painterSaveUpdated => 'Изменения сохранены!';

  @override
  String get painterShareFailed => 'Не удалось открыть меню экспорта';

  @override
  String get painterSaveFailed => 'Не удалось сохранить рисунок';

  @override
  String get painterLoadEditFailed =>
      'Не удалось загрузить изображение для редактирования';
}
