import 'package:aezakmi_test_task/domain/entities/image_entity.dart';
import 'package:aezakmi_test_task/features/gallery/model/image_ui_model.dart';
import 'package:aezakmi_test_task/l10n/app_localizations.dart';

extension ImageEntityUiMapper on ImageEntity {
  ImageUiModel toUiModel(AppLocalizations l10n, DateTime now) {
    return ImageUiModel(
      id: id,
      bytes: bytes,
      imageUrl: imageUrl,
      name: name,
      fileName: fileName,
      authorName: authorName,
      authorEmail: authorEmail,
      formattedDate: _formatDate(l10n, createdAt, now),
      formattedFileSize: _formatFileSize(fileSize),
      isEdited: isEdited,
    );
  }
}


String _formatDate(AppLocalizations l10n, DateTime? date, DateTime now) {
  if (date == null) return l10n.unknown;

  final diff = now.difference(date);

  if (diff.inMinutes < 1) return l10n.justNow;
  if (diff.inHours < 1) return l10n.minutesAgo(diff.inMinutes);
  if (diff.inDays < 1) return l10n.hoursAgo(diff.inHours);
  if (diff.inDays < 7) return l10n.daysAgo(diff.inDays);

  return '${date.day}.${date.month}.${date.year}';
}

String _formatFileSize(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
}
