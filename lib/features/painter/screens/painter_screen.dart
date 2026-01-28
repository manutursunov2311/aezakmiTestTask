import 'dart:io';
import 'dart:typed_data' show ByteData, Uint8List;
import 'dart:ui' as ui;

import 'package:aezakmi_test_task/core/config/app_assets.dart';
import 'package:aezakmi_test_task/core/di/service_locator.dart';
import 'package:aezakmi_test_task/features/gallery/model/image_ui_model.dart';
import 'package:aezakmi_test_task/features/painter/store/painter_store.dart';
import 'package:aezakmi_test_task/features/painter/widgets/drawing_painter.dart';
import 'package:aezakmi_test_task/features/painter/widgets/drawing_point.dart';
import 'package:aezakmi_test_task/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RenderRepaintBoundary;
import 'package:flutter_mobx/flutter_mobx.dart' show Observer;
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart' show ReactionDisposer, reaction;

class PainterScreen extends StatefulWidget {
  final ImageUiModel? imageToEdit;

  const PainterScreen({super.key, this.imageToEdit});

  @override
  State<PainterScreen> createState() => _PainterScreenState();
}

class _PainterScreenState extends State<PainterScreen> {
  List<DrawingPoint> drawingPoints = [];
  Color selectedColor = const Color(0xFF6B9BD1);
  double strokeWidth = 3.0;
  bool isEraser = false;
  bool showColorPicker = false;
  File? backgroundImage;
  ui.Image? loadedImage;
  bool isNewImage = true;

  List<ReactionDisposer>? _disposers;
  final GlobalKey _canvasGlobalKey = GlobalKey();

  final PainterStore _store = getIt<PainterStore>();

  @override
  void initState() {
    super.initState();

    _store.resetEditState();

    if (widget.imageToEdit != null) {
      isNewImage = false;
      _store.loadEditBytes(
        bytes: widget.imageToEdit!.bytes,
        imageUrl: widget.imageToEdit!.imageUrl,
      );
    }

    _disposers = [
      reaction((_) => _store.editBytes, (Uint8List? b) async {
        if (b == null) return;
        try {
          final img = await decodeImageFromList(b);
          if (!mounted) return;
          setState(() => loadedImage = img);
        } catch (e) {
          _store.event = PainterEvent.loadEditFailed;
          _store.details = e.toString();
        }
      }),

      reaction((_) => _store.event, (PainterEvent? ev) {
        if (ev == null) return;

        final t = AppLocalizations.of(context)!;

        final isError = ev == PainterEvent.notAuthorized ||
            ev == PainterEvent.shareFailed ||
            ev == PainterEvent.saveFailed ||
            ev == PainterEvent.loadEditFailed;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showDialog(
            t,
            isError ? t.errorTitle : t.successTitle,
            _eventText(t, ev),
          );
        });

        _store.clearEvent();
      }),
    ];
  }

  String _eventText(AppLocalizations t, PainterEvent ev) {
    switch (ev) {
      case PainterEvent.shareSuccess:
        return t.painterShareSuccess;
      case PainterEvent.shareDismissed:
        return t.painterShareDismissed;
      case PainterEvent.saveCreated:
        return t.painterSaveCreated;
      case PainterEvent.saveUpdated:
        return t.painterSaveUpdated;
      case PainterEvent.notAuthorized:
        return t.errorNotAuthorized;
      case PainterEvent.shareFailed:
        return t.painterShareFailed;
      case PainterEvent.saveFailed:
        return t.painterSaveFailed;
      case PainterEvent.loadEditFailed:
        return t.painterLoadEditFailed;
    }
  }

  @override
  void dispose() {
    _disposers?.forEach((d) => d());
    super.dispose();
  }

  void _showDialog(AppLocalizations t, String title, String message) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(title),
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

  Future<Uint8List?> _captureCanvas() async {
    try {
      RenderRepaintBoundary? boundary = _canvasGlobalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) return null;

      print("captureCanvas: $boundary");
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print("Ошибка захвата: $e");
      return null;
    }
  }

  Future<void> _handleShare() async {
    final bytes = await _captureCanvas();

    if (bytes != null) {
      _store.shareImage(bytes);
    }
  }

  Future<void> _handleSave() async {
    final bytes = await _captureCanvas();
    if (bytes != null) {
      await _store.saveOrUpdateImage(
        bytes,
        widget.imageToEdit?.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      backgroundColor: Colors.transparent,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          isNewImage ? l10n.painterNewTitle : l10n.painterEditTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4,
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).pop(),
          child: SvgPicture.asset(
           AppAssets.icons.iconArrowBack,
            width: 24,
            height: 24,
          )
        ),
        trailing: Observer(
          builder: (_) {
            final loading = _store.isLoading;
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: loading ? null : _handleSave,
              child: loading
                  ? const CupertinoActivityIndicator()
                  : SvgPicture.asset(AppAssets.icons.iconCheck),
            );
          },
        ),
      ),
      child: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _buildToolsBar(),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Observer(
                      builder: (_) {
                        final loading = _store.isEditLoading;

                        if (!isNewImage && loading) {
                          return const Center(child: CupertinoActivityIndicator());
                        }

                        return _buildCanvas();
                      },
                    ),
                  ),
                  const SizedBox(height: 60)
                ],
              ),
            ),
          ),
          if (showColorPicker) _buildColorPickerTooltip(),
        ],
      ),
    );
  }

  Widget _buildToolsBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildToolButton(
            icon: AppAssets.icons.iconDownload,
            onPressed: _handleShare,
            isActive: false,
          ),
          const SizedBox(width: 12),
          _buildToolButton(
            icon: AppAssets.icons.iconGallery,
            onPressed: _pickImage,
            isActive: false,
          ),
          const SizedBox(width: 12),
          _buildToolButton(
            icon: AppAssets.icons.iconPencil,
            onPressed: () {
              setState(() {
                isEraser = false;
                showColorPicker = false;
              });
            },
            isActive: !isEraser && !showColorPicker,
          ),
          const SizedBox(width: 12),
          _buildToolButton(
            icon: AppAssets.icons.iconErase,
            onPressed: () {
              setState(() {
                isEraser = true;
                showColorPicker = false;
              });
            },
            isActive: isEraser,
          ),
          const SizedBox(width: 12),
          _buildToolButton(
            icon: AppAssets.icons.iconPalette,
            onPressed: () {
              setState(() {
                showColorPicker = !showColorPicker;
                isEraser = false;
              });
            },
            isActive: showColorPicker,
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required String icon,
    required VoidCallback onPressed,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0A84FF) : const Color(0xFF3A3A3C),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }

  Widget _buildColorPickerTooltip() {
    return Positioned(
      right: 16,
      top: 160,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              _buildColorGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorGrid() {
    // Create a color grid similar to iOS color picker
    final List<List<Color>> colorRows = [
      // Row 1: Grays
      [
        const Color(0xFFFFFFFF),
        const Color(0xFFE0E0E0),
        const Color(0xFFC0C0C0),
        const Color(0xFFA0A0A0),
        const Color(0xFF808080),
        const Color(0xFF606060),
        const Color(0xFF404040),
        const Color(0xFF202020),
        const Color(0xFF000000),
      ],
      // Row 2: Dark colors
      [
        const Color(0xFF004D4D),
        const Color(0xFF003D7A),
        const Color(0xFF2D1B69),
        const Color(0xFF5A1A5A),
        const Color(0xFF7A1A1A),
        const Color(0xFF7A3A1A),
        const Color(0xFF5A4A1A),
        const Color(0xFF4A5A1A),
        const Color(0xFF1A4A1A),
      ],
      // Row 3: Medium colors
      [
        const Color(0xFF008080),
        const Color(0xFF0066CC),
        const Color(0xFF5C3399),
        const Color(0xFF993399),
        const Color(0xFFCC3333),
        const Color(0xFFCC6633),
        const Color(0xFF999933),
        const Color(0xFF669933),
        const Color(0xFF339933),
      ],
      // Row 4: Bright colors
      [
        const Color(0xFF00CCCC),
        const Color(0xFF3399FF),
        const Color(0xFF9966FF),
        const Color(0xFFFF66FF),
        const Color(0xFFFF6666),
        const Color(0xFFFF9933),
        const Color(0xFFFFCC33),
        const Color(0xFFCCFF33),
        const Color(0xFF66FF66),
      ],
      // Row 5: Light colors
      [
        const Color(0xFF99FFFF),
        const Color(0xFF99CCFF),
        const Color(0xFFCC99FF),
        const Color(0xFFFF99FF),
        const Color(0xFFFFCCCC),
        const Color(0xFFFFCC99),
        const Color(0xFFFFFF99),
        const Color(0xFFCCFF99),
        const Color(0xFF99FF99),
      ],
    ];

    return Column(
      children: colorRows.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: row.map((color) {
              final isSelected = _colorsAreClose(selectedColor, color);
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = color;
                      isEraser = false;
                    });
                  },
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: isSelected
                            ? [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.6),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ]
                            : null,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  bool _colorsAreClose(Color c1, Color c2) {
    return (c1.red - c2.red).abs() < 10 &&
        (c1.green - c2.green).abs() < 10 &&
        (c1.blue - c2.blue).abs() < 10;
  }

  Widget _buildCanvas() {
    return Container(
      margin: const EdgeInsets.only(left: 21, right: 21, top: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: RepaintBoundary(
          key: _canvasGlobalKey,
          child: GestureDetector(
            onPanStart: (details) {
              setState(() {
                drawingPoints.add(
                  DrawingPoint(
                    offset: details.localPosition,
                    paint: Paint()
                      ..color = isEraser ? Colors.white : selectedColor
                      ..strokeWidth = isEraser ? strokeWidth * 3 : strokeWidth
                      ..strokeCap = StrokeCap.round,
                  ),
                );
              });
            },
            onPanUpdate: (details) {
              setState(() {
                drawingPoints.add(
                  DrawingPoint(
                    offset: details.localPosition,
                    paint: Paint()
                      ..color = isEraser ? Colors.white : selectedColor
                      ..strokeWidth = isEraser ? strokeWidth * 3 : strokeWidth
                      ..strokeCap = StrokeCap.round,
                  ),
                );
              });
            },
            onPanEnd: (details) {
              setState(() {
                drawingPoints.add(DrawingPoint(offset: null, paint: null));
              });
            },
            child: CustomPaint(
              painter: DrawingPainter(
                drawingPoints: drawingPoints,
                backgroundImage: loadedImage,
              ),
              child: Container(),
            ),
          ),
        )
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final bytes = await file.readAsBytes();
      final image = await decodeImageFromList(bytes);

      setState(() {
        backgroundImage = file;
        loadedImage = image;
        isNewImage = false;
        drawingPoints.clear();
      });
    }
  }

  void _clearCanvas() {
    setState(() {
      drawingPoints.clear();
      backgroundImage = null;
      loadedImage = null;
      isNewImage = true;
    });
  }
}