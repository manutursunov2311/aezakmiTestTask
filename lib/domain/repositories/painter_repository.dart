import 'dart:typed_data';

enum ShareStatus { success, dismissed }

abstract class PainterRepository {
  Future<ShareStatus> sharePng(Uint8List bytes);
  Future<void> saveOrUpdateDrawing({
    required Uint8List bytes,
    String? documentId,
  });
  Future<Uint8List> downloadImageBytes(String url);
}
