import 'package:aezakmi_test_task/domain/entities/image_entity.dart';
import 'package:aezakmi_test_task/domain/repositories/firebase_repository.dart';
import 'package:mobx/mobx.dart';

part 'gallery_store.g.dart';

enum GalleryError { loadFailed, deleteFailed, logoutFailed }

class GalleryStore = _GalleryStore with _$GalleryStore;

abstract class _GalleryStore with Store {
  final FirebaseRepository _firebaseRepository;

  _GalleryStore(this._firebaseRepository);

  @observable
  ObservableList<ImageEntity> images = ObservableList<ImageEntity>();

  @observable
  bool isLoading = false;

  @observable
  GalleryError? error;

  @observable
  String? errorDetails;

  @action
  Future<void> loadImages() async {
    isLoading = true;
    error = null;
    errorDetails = null;

    try {
      final entities = await _firebaseRepository.fetchImages();
      images
        ..clear()
        ..addAll(entities);
    } catch (e) {
      error = GalleryError.loadFailed;
      errorDetails = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> deleteImage(String imageId) async {
    error = null;
    errorDetails = null;

    try {
      await _firebaseRepository.deleteImage(imageId);
      images.removeWhere((img) => img.id == imageId);
    } catch (e) {
      error = GalleryError.deleteFailed;
      errorDetails = e.toString();
    }
  }

  @action
  Future<void> logout() async {
    try {
      await _firebaseRepository.signOut();
      images.clear();
    } catch (e) {
      error = GalleryError.logoutFailed;
      errorDetails = e.toString();
    }
  }

  @action
  void clearError() {
    error = null;
    errorDetails = null;
  }
}
