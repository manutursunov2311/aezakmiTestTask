abstract class NotificationRepository {
  Future<void> showSuccess(String title, String body);
  Future<void> showError(String title, String body);
}
