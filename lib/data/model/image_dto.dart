import 'dart:typed_data' show Uint8List;
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageDto {
  final String id;
  final String? imageUrl;
  final String? storagePath;
  final Uint8List? imageBytes;
  final String name;
  final String fileName;
  final String authorName;
  final String authorEmail;
  final DateTime? createdAt;
  final bool isEdited;
  final int fileSize;

  ImageDto({
    required this.id,
    required this.imageUrl,
    required this.storagePath,
    required this.imageBytes,
    required this.name,
    required this.fileName,
    required this.authorName,
    required this.authorEmail,
    required this.createdAt,
    required this.isEdited,
    required this.fileSize,
  });

  factory ImageDto.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc,
      ) {
    final data = doc.data();

    return ImageDto(
      id: doc.id,
      imageUrl: data['imageUrl'] as String?,
      storagePath: data['storagePath'] as String?,
      imageBytes: null,
      name: (data['name'] as String?) ?? 'Без названия',
      fileName: (data['fileName'] as String?) ?? '',
      authorName: (data['authorName'] as String?) ?? 'User',
      authorEmail: (data['authorEmail'] as String?) ?? 'Anonymous',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      isEdited: (data['isEdited'] as bool?) ?? false,
      fileSize: (data['fileSize'] as int?) ?? 0,
    );
  }
}
