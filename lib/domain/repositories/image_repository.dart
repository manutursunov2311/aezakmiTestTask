import 'dart:typed_data';
import '../entities/image_entity.dart';

abstract class ImageRepository {
  Future<List<ImageEntity>> fetchImages();
  Future<void> deleteImage(String imageId);

  Future<void> createImage({
    required Uint8List bytes,
    required String name,
    required String fileName,
    required int fileSize,
    required String mimeType,
  });

  Future<void> updateImage({
    required String id,
    required Uint8List bytes,
    required int fileSize,
  });
}
