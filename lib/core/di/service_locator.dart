import 'package:aezakmi_test_task/core/connectivity/connectivity_store.dart';
import 'package:aezakmi_test_task/core/service/notification_service.dart';
import 'package:aezakmi_test_task/data/repositories/auth_repository_impl.dart';
import 'package:aezakmi_test_task/data/repositories/firebase_repository_impl.dart';
import 'package:aezakmi_test_task/data/repositories/painter_repository_impl.dart';
import 'package:aezakmi_test_task/domain/repositories/auth_repository.dart';
import 'package:aezakmi_test_task/domain/repositories/firebase_repository.dart';
import 'package:aezakmi_test_task/domain/repositories/painter_repository.dart';
import 'package:aezakmi_test_task/features/auth/store/login_store.dart';
import 'package:aezakmi_test_task/features/auth/store/register_store.dart';
import 'package:aezakmi_test_task/features/gallery/store/gallery_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import '../../features/painter/store/painter_store.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<NotificationService>(() => NotificationService());

  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getIt.registerLazySingleton<FirebaseStorage>(
        () => FirebaseStorage.instance,
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<FirebaseAuth>()),
  );

  getIt.registerLazySingleton<FirebaseRepository>(
    () => FirebaseRepositoryImpl(
      getIt<FirebaseAuth>(),
      getIt<FirebaseFirestore>(),
      getIt<FirebaseStorage>()
    ),
  );

  getIt.registerLazySingleton<PainterRepository>(
    () => PainterRepositoryImpl(
      getIt<FirebaseAuth>(),
      getIt<FirebaseFirestore>(),
      getIt<FirebaseStorage>(),
      getIt<NotificationService>(),
    ),
  );

  getIt.registerLazySingleton<ConnectivityStore>(() => ConnectivityStore(getIt<Connectivity>()));

  getIt.registerFactory<PainterStore>(() => PainterStore(getIt<PainterRepository>()));

  getIt.registerFactory<LoginStore>(() => LoginStore(getIt<AuthRepository>()));

  getIt.registerFactory<RegisterStore>(
    () => RegisterStore(getIt<AuthRepository>()),
  );

  getIt.registerFactory<GalleryStore>(
    () => GalleryStore(getIt<FirebaseRepository>()),
  );
}
