import 'dart:typed_data';

import 'package:aezakmi_test_task/domain/repositories/painter_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'painter_store.g.dart';

enum PainterEvent {
  shareSuccess,
  shareDismissed,
  saveCreated,
  saveUpdated,
  notAuthorized,
  shareFailed,
  saveFailed,
  loadEditFailed,
}

class PainterStore = _PainterStore with _$PainterStore;

abstract class _PainterStore with Store {
  final PainterRepository _repo;
  _PainterStore(this._repo);

  @observable
  bool isLoading = false;

  @observable
  PainterEvent? event;

  @observable
  bool isEditLoading = false;

  @observable
  String? details;

  @observable
  Uint8List? editBytes;

  @action
  void clearEvent() {
    event = null;
    details = null;
  }

  @action
  Future<void> shareImage(Uint8List bytes) async {
    isLoading = true;
    clearEvent();

    try {
      final status = await _repo.sharePng(bytes);
      event = status == ShareStatus.success
          ? PainterEvent.shareSuccess
          : PainterEvent.shareDismissed;
    } catch (e) {
      event = PainterEvent.shareFailed;
      details = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> saveOrUpdateImage(Uint8List bytes, String? documentId) async {
    isLoading = true;
    clearEvent();

    try {
      await _repo.saveOrUpdateDrawing(bytes: bytes, documentId: documentId);
      event = documentId != null ? PainterEvent.saveUpdated : PainterEvent.saveCreated;
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('NOT_AUTHORIZED')) {
        event = PainterEvent.notAuthorized;
      } else {
        event = PainterEvent.saveFailed;
      }
      details = msg;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadEditBytes({Uint8List? bytes, String? imageUrl}) async {
    isEditLoading = true;
    clearEvent();

    try {
      if (bytes != null) {
        editBytes = bytes;
      } else if (imageUrl == null || imageUrl.isEmpty) {
        editBytes = null;
      } else {
        editBytes = await _repo.downloadImageBytes(imageUrl);
      }
    } catch (e) {
      event = PainterEvent.loadEditFailed;
      details = e.toString();
    } finally {
      isEditLoading = false;
    }
  }

  @action
  void resetEditState() {
    isEditLoading = false;
    editBytes = null;
  }
}

