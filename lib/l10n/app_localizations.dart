import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ru')];

  /// No description provided for @errorTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка'**
  String get errorTitle;

  /// No description provided for @ok.
  ///
  /// In ru, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @loginTitle.
  ///
  /// In ru, this message translates to:
  /// **'Вход'**
  String get loginTitle;

  /// No description provided for @registerTitle.
  ///
  /// In ru, this message translates to:
  /// **'Регистрация'**
  String get registerTitle;

  /// No description provided for @loginButton.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get loginButton;

  /// No description provided for @registerButton.
  ///
  /// In ru, this message translates to:
  /// **'Зарегистрироваться'**
  String get registerButton;

  /// No description provided for @labelEmail.
  ///
  /// In ru, this message translates to:
  /// **'e-mail'**
  String get labelEmail;

  /// No description provided for @phEmailLogin.
  ///
  /// In ru, this message translates to:
  /// **'Введите электронную почту'**
  String get phEmailLogin;

  /// No description provided for @phEmailRegister.
  ///
  /// In ru, this message translates to:
  /// **'Ваша электронная почта'**
  String get phEmailRegister;

  /// No description provided for @labelPassword.
  ///
  /// In ru, this message translates to:
  /// **'Пароль'**
  String get labelPassword;

  /// No description provided for @phPasswordLogin.
  ///
  /// In ru, this message translates to:
  /// **'Введите пароль'**
  String get phPasswordLogin;

  /// No description provided for @phPasswordRegister.
  ///
  /// In ru, this message translates to:
  /// **'8-16 символов'**
  String get phPasswordRegister;

  /// No description provided for @labelName.
  ///
  /// In ru, this message translates to:
  /// **'Имя'**
  String get labelName;

  /// No description provided for @phName.
  ///
  /// In ru, this message translates to:
  /// **'Введите ваше имя'**
  String get phName;

  /// No description provided for @labelConfirmPassword.
  ///
  /// In ru, this message translates to:
  /// **'Подтверждение пароля'**
  String get labelConfirmPassword;

  /// No description provided for @phConfirmPassword.
  ///
  /// In ru, this message translates to:
  /// **'8-16 символов'**
  String get phConfirmPassword;

  /// No description provided for @unknown.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестно'**
  String get unknown;

  /// No description provided for @justNow.
  ///
  /// In ru, this message translates to:
  /// **'только что'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In ru, this message translates to:
  /// **'{minutes} мин назад'**
  String minutesAgo(Object minutes);

  /// No description provided for @hoursAgo.
  ///
  /// In ru, this message translates to:
  /// **'{hours} ч назад'**
  String hoursAgo(Object hours);

  /// No description provided for @daysAgo.
  ///
  /// In ru, this message translates to:
  /// **'{days} д назад'**
  String daysAgo(Object days);

  /// No description provided for @valEmailEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, введите email.'**
  String get valEmailEmpty;

  /// No description provided for @valEmailInvalid.
  ///
  /// In ru, this message translates to:
  /// **'Некорректный формат email.'**
  String get valEmailInvalid;

  /// No description provided for @valPasswordEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, введите пароль.'**
  String get valPasswordEmpty;

  /// No description provided for @valPasswordInvalid.
  ///
  /// In ru, this message translates to:
  /// **'Пароль должен содержать минимум 8 символов.'**
  String get valPasswordInvalid;

  /// No description provided for @valNameEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, введите имя.'**
  String get valNameEmpty;

  /// No description provided for @valConfirmPasswordEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, подтвердите пароль.'**
  String get valConfirmPasswordEmpty;

  /// No description provided for @valPasswordsMismatch.
  ///
  /// In ru, this message translates to:
  /// **'Пароли не совпадают.'**
  String get valPasswordsMismatch;

  /// No description provided for @errorNotAuthorized.
  ///
  /// In ru, this message translates to:
  /// **'Пользователь не авторизован'**
  String get errorNotAuthorized;

  /// No description provided for @errorDelete.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка удаления изображения: {error}'**
  String errorDelete(Object error);

  /// No description provided for @galleryTitle.
  ///
  /// In ru, this message translates to:
  /// **'Галерея'**
  String get galleryTitle;

  /// No description provided for @create.
  ///
  /// In ru, this message translates to:
  /// **'Создать'**
  String get create;

  /// No description provided for @galleryEmptyTitle.
  ///
  /// In ru, this message translates to:
  /// **'Галерея пуста'**
  String get galleryEmptyTitle;

  /// No description provided for @galleryEmptySubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Создайте свой первый рисунок'**
  String get galleryEmptySubtitle;

  /// No description provided for @deleteImageTitle.
  ///
  /// In ru, this message translates to:
  /// **'Удалить изображение?'**
  String get deleteImageTitle;

  /// No description provided for @deleteImageBody.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить \"{name}\"?'**
  String deleteImageBody(Object name);

  /// No description provided for @cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get delete;

  /// No description provided for @logoutTitle.
  ///
  /// In ru, this message translates to:
  /// **'Выход'**
  String get logoutTitle;

  /// No description provided for @logoutBody.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите выйти?'**
  String get logoutBody;

  /// No description provided for @logout.
  ///
  /// In ru, this message translates to:
  /// **'Выйти'**
  String get logout;

  /// No description provided for @errorLoadImages.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки изображений'**
  String get errorLoadImages;

  /// No description provided for @errorDeleteImage.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка удаления изображения'**
  String get errorDeleteImage;

  /// No description provided for @errorLogout.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка выхода'**
  String get errorLogout;

  /// No description provided for @successTitle.
  ///
  /// In ru, this message translates to:
  /// **'Успешно'**
  String get successTitle;

  /// No description provided for @painterNewTitle.
  ///
  /// In ru, this message translates to:
  /// **'Новое изображение'**
  String get painterNewTitle;

  /// No description provided for @painterEditTitle.
  ///
  /// In ru, this message translates to:
  /// **'Редактирование'**
  String get painterEditTitle;

  /// No description provided for @colorPickerTitle.
  ///
  /// In ru, this message translates to:
  /// **'Выбор цвета'**
  String get colorPickerTitle;

  /// No description provided for @painterShareSuccess.
  ///
  /// In ru, this message translates to:
  /// **'Рисунок успешно отправлен'**
  String get painterShareSuccess;

  /// No description provided for @painterShareDismissed.
  ///
  /// In ru, this message translates to:
  /// **'Меню экспорта закрыто'**
  String get painterShareDismissed;

  /// No description provided for @painterSaveCreated.
  ///
  /// In ru, this message translates to:
  /// **'Новый рисунок создан!'**
  String get painterSaveCreated;

  /// No description provided for @painterSaveUpdated.
  ///
  /// In ru, this message translates to:
  /// **'Изменения сохранены!'**
  String get painterSaveUpdated;

  /// No description provided for @painterShareFailed.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось открыть меню экспорта'**
  String get painterShareFailed;

  /// No description provided for @painterSaveFailed.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось сохранить рисунок'**
  String get painterSaveFailed;

  /// No description provided for @painterLoadEditFailed.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось загрузить изображение для редактирования'**
  String get painterLoadEditFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
