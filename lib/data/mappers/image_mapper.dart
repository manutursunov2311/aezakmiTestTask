import 'package:aezakmi_test_task/data/model/image_dto.dart';
import 'package:aezakmi_test_task/domain/entities/image_entity.dart';

extension ImageDtoMapper on ImageDto {
  ImageEntity toEntity() {
    return ImageEntity(
      id: id,
      bytes: imageBytes,
      imageUrl: imageUrl,
      storagePath: storagePath,
      name: name,
      fileName: fileName,
      authorName: authorName,
      authorEmail: authorEmail,
      createdAt: createdAt,
      isEdited: isEdited,
      fileSize: fileSize,
    );
  }
}
