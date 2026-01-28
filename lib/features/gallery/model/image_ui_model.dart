import 'dart:typed_data';

class ImageUiModel {
  final String id;

  final Uint8List? bytes;
  final String? imageUrl;

  final String name;
  final String fileName;
  final String authorName;
  final String authorEmail;
  final String formattedDate;
  final String formattedFileSize;
  final bool isEdited;

  const ImageUiModel({
    required this.id,
    required this.bytes,
    required this.imageUrl,
    required this.name,
    required this.fileName,
    required this.authorName,
    required this.authorEmail,
    required this.formattedDate,
    required this.isEdited,
    required this.formattedFileSize,
  });
}
