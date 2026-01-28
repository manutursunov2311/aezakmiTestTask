import 'dart:ui';

import 'package:aezakmi_test_task/core/config/app_assets.dart';
import 'package:aezakmi_test_task/core/di/service_locator.dart';
import 'package:aezakmi_test_task/features/gallery/mappers/image_ui_mapper.dart';
import 'package:aezakmi_test_task/features/gallery/model/image_ui_model.dart';
import 'package:aezakmi_test_task/features/painter/screens/painter_screen.dart';
import 'package:aezakmi_test_task/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:mobx/mobx.dart' show ReactionDisposer, reaction;
import '../store/gallery_store.dart';
import '../widgets/gallery_item.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final GalleryStore _store = getIt<GalleryStore>();

  ReactionDisposer? _errorDisposer;

  @override
  void initState() {
    super.initState();
    _store.loadImages();

    _errorDisposer = reaction((_) => _store.error, (GalleryError? err) {
      if (err != null) {
        final t = AppLocalizations.of(context)!;
        _showErrorDialog(t, _errorText(t, err));
        _store.clearError();
      }
    });
  }

  @override
  void dispose() {
    _errorDisposer?.call();
    super.dispose();
  }

  String _errorText(AppLocalizations t, GalleryError err) {
    switch (err) {
      case GalleryError.loadFailed:
        return t.errorLoadImages;
      case GalleryError.deleteFailed:
        return t.errorDeleteImage;
      case GalleryError.logoutFailed:
        return t.errorLogout;
    }
  }

  void _showErrorDialog(AppLocalizations t, String message) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(t.errorTitle),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text(t.ok),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(t.logoutTitle),
        content: Text(t.logoutBody),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(ctx),
            child: Text(t.cancel),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.pop(ctx);
              await _store.logout();
            },
            child: Text(t.logout),
          ),
        ],
      ),
    );
  }


  void _showDeleteConfirmation(BuildContext context, ImageUiModel image) {
    final t = AppLocalizations.of(context)!;

    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(t.deleteImageTitle),
        content: Text(t.deleteImageBody(image.name)),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(ctx),
            child: Text(t.cancel),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(ctx);
              _store.deleteImage(image.id);
            },
            child: Text(t.delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAssets.backgroundImage, fit: BoxFit.cover),
          ),

          Positioned.fill(
            child: Observer(
              builder: (_) {
                final now = DateTime.now();
                final uiImages =
                _store.images.map((e) => e.toUiModel(t, now)).toList();

                if (_store.isLoading) {
                  return const Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.white,
                      radius: 20,
                    ),
                  );
                }

                if (uiImages.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.photo_on_rectangle,
                            size: 64,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            t.galleryEmptyTitle,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            t.galleryEmptySubtitle,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 120, 20, 100),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: uiImages.length,
                  itemBuilder: (context, index) {
                    final imageModel = uiImages[index];

                    return GalleryItem(
                      imageUiModel: imageModel,
                      onTap: () async {
                        await Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (_) =>
                                PainterScreen(imageToEdit: imageModel),
                          ),
                        );
                        _store.loadImages();
                      },
                      onDelete: () => _showDeleteConfirmation(context, imageModel),
                    );
                  },
                );
              },
            ),
          ),

          //AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildGlassAppBar(t),
          ),

          Positioned(
            left: 20,
            right: 20,
            bottom: 34,
            child: SafeArea(
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8924E7), Color(0xFF6A46F9)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (_) => const PainterScreen(),
                      ),
                    );
                    _store.loadImages();
                  },
                  child: Text(
                    t.create,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassAppBar(AppLocalizations t) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFC4C4C4).withOpacity(0.01),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFFE3E3E3).withOpacity(0.2),
                Colors.transparent,
              ],
              stops: const [0.0, 0.35],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    minSize: 0,
                    onPressed: () => _showLogoutConfirmation(context),
                    child: SvgPicture.asset(AppAssets.icons.iconLogout),
                  ),

                  Text(
                    t.galleryTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      fontFamily: '.SF Pro Display',
                    ),
                  ),

                  Observer(
                    builder: (_) => _store.images.isNotEmpty
                        ? CupertinoButton(
                      padding: EdgeInsets.zero,
                      minSize: 0,
                      onPressed: _store.loadImages,
                      child: SvgPicture.asset(AppAssets.icons.iconPaintRoller),
                    ) : const SizedBox(width: 26),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
