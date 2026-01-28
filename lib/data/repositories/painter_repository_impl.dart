import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import '../../core/service/notification_service.dart';
import '../../domain/repositories/painter_repository.dart';

class PainterRepositoryImpl implements PainterRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final NotificationService _notifications;

  PainterRepositoryImpl(
    this._auth,
    this._firestore,
    this._storage,
    this._notifications,
  );

  User _requireUser() {
    final user = _auth.currentUser;
    if (user == null) throw Exception('NOT_AUTHORIZED');
    return user;
  }

  @override
  Future<ShareStatus> sharePng(Uint8List bytes) async {
    try {
      final dir = await getTemporaryDirectory();
      final file = File(
        '${dir.path}/drawing_share_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await file.writeAsBytes(bytes);

      final result = await Share.shareXFiles([XFile(file.path)]);
      if (result.status == ShareResultStatus.success) {
        return ShareStatus.success;
      }
      return ShareStatus.dismissed;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveOrUpdateDrawing({
    required Uint8List bytes,
    String? documentId,
  }) async {
    final user = _requireUser();

    final fileName = '${const Uuid().v4()}.png';
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);

    try {
      await Gal.putImage(file.path, album: 'Painter App');
    } catch (_) {}

    String storagePath;

    if (documentId != null) {
      final doc = await _firestore.collection('images').doc(documentId).get();
      final data = doc.data();
      storagePath = (data?['storagePath'] as String?) ??
          'images/${user.uid}/${const Uuid().v4()}.png';
    } else {
      storagePath = 'images/${user.uid}/${const Uuid().v4()}.png';
    }

    final ref = _storage.ref(storagePath);

    await ref.putData(
      bytes,
      SettableMetadata(contentType: 'image/png'),
    );

    final downloadUrl = await ref.getDownloadURL();

    if (documentId != null) {
      await _firestore.collection('images').doc(documentId).update({
        'imageUrl': downloadUrl,
        'storagePath': storagePath,
        'isEdited': true,
        'fileSize': bytes.length,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      await _notifications.showSuccessNotification('Успешно', 'Рисунок обновлен');
    } else {
      await _firestore.collection('images').add({
        'imageUrl': downloadUrl,
        'storagePath': storagePath,
        'userId': user.uid,
        'authorEmail': user.email ?? 'Anonymous',
        'authorName': user.displayName ?? 'User',
        'createdAt': FieldValue.serverTimestamp(),
        'fileName': fileName,
        'name': 'Новый рисунок',
        'isEdited': false,
        'fileSize': bytes.length,
        'mimeType': 'image/png',
      });

      await _notifications.showSuccessNotification('Успешно', 'Рисунок создан');
    }
  }

  @override
  Future<Uint8List> downloadImageBytes(String url) async {
    final resp = await http
        .get(Uri.parse(url))
        .timeout(const Duration(seconds: 15));

    if (resp.statusCode != 200) {
      throw Exception('IMAGE_DOWNLOAD_FAILED_${resp.statusCode}');
    }

    return resp.bodyBytes;
  }
}
