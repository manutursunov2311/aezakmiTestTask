import '../entities/image_entity.dart';

abstract class FirebaseRepository {
  Future<List<ImageEntity>> fetchImages();
  Future<void> deleteImage(String imageId);
  Future<void> signOut();
}
