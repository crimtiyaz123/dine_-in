// lib/core/services/notification_service_stub.dart

class NotificationService {
  // Singleton pattern (like the real service)
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  /// Stub init function — does nothing on Web
  Future<void> init() async {
    // No-op for Web
  }

  /// Stub for showNotification — does nothing
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    // Stub implementation - no-op
  }

  /// Stub for scheduleNotification — does nothing
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    // No-op for Web
  }
}
