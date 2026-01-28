import 'dart:typed_data';

class ImageEntity {
  final String id;

  final Uint8List? bytes;
  final String? imageUrl;
  final String? storagePath;

  final String name;
  final String fileName;
  final String authorName;
  final String authorEmail;
  final DateTime? createdAt;
  final bool isEdited;
  final int fileSize;

  ImageEntity({
    required this.id,
    required this.bytes,
    required this.imageUrl,
    required this.storagePath,
    required this.name,
    required this.fileName,
    required this.authorName,
    required this.authorEmail,
    required this.createdAt,
    required this.isEdited,
    required this.fileSize,
  });
}
