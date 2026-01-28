import 'package:aezakmi_test_task/core/connectivity/connectivity_store.dart';
import 'package:aezakmi_test_task/core/connectivity/connectivity_widget.dart';
import 'package:aezakmi_test_task/core/di/service_locator.dart';
import 'package:aezakmi_test_task/core/service/notification_service.dart';
import 'package:aezakmi_test_task/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart' show GlobalWidgetsLocalizations, GlobalCupertinoLocalizations, GlobalMaterialLocalizations;
import 'features/splash/splash_screen.dart';
import 'l10n/app_localizations.dart' show AppLocalizations;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupDependencies();

  await getIt<NotificationService>().init();

  await getIt<ConnectivityStore>().start();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Art App',
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF6F35A5),
        scaffoldBackgroundColor: Color(0xFF17171C),
      ),
      locale: const Locale('ru'),
      supportedLocales: const [Locale('ru')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      home: const ConnectivityWidget(child: SplashScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
