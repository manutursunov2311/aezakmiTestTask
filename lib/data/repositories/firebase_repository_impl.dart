import 'package:aezakmi_test_task/data/mappers/image_mapper.dart';
import 'package:aezakmi_test_task/data/model/image_dto.dart';
import 'package:aezakmi_test_task/domain/entities/image_entity.dart';
import 'package:aezakmi_test_task/domain/repositories/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseRepositoryImpl extends FirebaseRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  FirebaseRepositoryImpl(this._firebaseAuth, this._firebaseFirestore, this._firebaseStorage);

  @override
  Future<List<ImageEntity>> fetchImages() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw Exception('Пользователь не авторизован');

    final querySnapshot = await _firebaseFirestore
        .collection('images')
        .where('userId', isEqualTo: user.uid)
        .limit(100)
        .get();

    final images = querySnapshot.docs
        .map((doc) => ImageDto.fromFirestore(doc))
        .map((model) => model.toEntity())
        .toList();

    images.sort((a, b) {
      if (a.createdAt == null && b.createdAt == null) return 0;
      if (a.createdAt == null) return 1;
      if (b.createdAt == null) return -1;
      return b.createdAt!.compareTo(a.createdAt!);
    });

    return images;
  }

  @override
  Future<void> deleteImage(String imageId) async {
    final docRef = _firebaseFirestore.collection('images').doc(imageId);
    final snap = await docRef.get();
    final data = snap.data();

    final storagePath = data?['storagePath'] as String?;
    if (storagePath != null && storagePath.isNotEmpty) {
      await _firebaseStorage.ref(storagePath).delete();
    }

    await docRef.delete();
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
