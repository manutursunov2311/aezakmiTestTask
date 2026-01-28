import 'package:aezakmi_test_task/features/gallery/model/image_ui_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GalleryItem extends StatelessWidget {
  final ImageUiModel imageUiModel;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const GalleryItem({
    super.key,
    required this.imageUiModel,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: CupertinoColors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildPreview(imageUiModel),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      CupertinoColors.transparent,
                      CupertinoColors.black.withOpacity(0.3),
                    ],
                  ),
                ),
              ),

              if (onDelete != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: CupertinoColors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: CupertinoColors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreview(ImageUiModel m) {
    if (m.bytes != null) {
      return Image.memory(m.bytes!, fit: BoxFit.cover);
    }
    if (m.imageUrl != null) {
      return Image.network(m.imageUrl!, fit: BoxFit.cover);
    }
    return _buildErrorPlaceholder();
  }


  Widget _buildErrorPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2D2D3A),
            const Color(0xFF1A1A24),
          ],
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: Colors.white24,
          size: 40,
        ),
      ),
    );
  }
}