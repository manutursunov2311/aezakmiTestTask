import 'dart:ui' as ui;

import 'package:aezakmi_test_task/features/painter/widgets/drawing_point.dart';
import 'package:flutter/cupertino.dart';

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint> drawingPoints;
  final ui.Image? backgroundImage;

  DrawingPainter({
    required this.drawingPoints,
    this.backgroundImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (backgroundImage != null) {
      canvas.drawImageRect(
        backgroundImage!,
        Rect.fromLTWH(
          0,
          0,
          backgroundImage!.width.toDouble(),
          backgroundImage!.height.toDouble(),
        ),
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint(),
      );
    }

    for (int i = 0; i < drawingPoints.length - 1; i++) {
      if (drawingPoints[i].offset != null &&
          drawingPoints[i + 1].offset != null) {
        canvas.drawLine(
          drawingPoints[i].offset!,
          drawingPoints[i + 1].offset!,
          drawingPoints[i].paint!,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}