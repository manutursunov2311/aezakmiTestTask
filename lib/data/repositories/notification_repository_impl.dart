import '../../domain/repositories/notification_repository.dart';
import '../../core/service/notification_service.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationService _service;
  NotificationRepositoryImpl(this._service);

  @override
  Future<void> showSuccess(String title, String body) =>
      _service.showSuccessNotification(title, body);

  @override
  Future<void> showError(String title, String body) =>
      _service.showSuccessNotification(title, body);
}
