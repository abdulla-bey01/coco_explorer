import 'dart:math';

import '/app/models/segmentation_model.dart';
import 'package:flutter/material.dart';

//draw segments to images based on size of image, and coordinated provided from data source
class SegmentationPainter extends CustomPainter {
  final List<SegmentationModel> segmentations;
  final Size? originalSize;

  SegmentationPainter({
    required this.segmentations,
    this.originalSize,
  });

  @override
  void paint(Canvas canvas, Size size) async {
    if (originalSize == null) return;
    //create paint object with fill-style to fill inside of segment with color

    var r = (Random().nextInt(255));
    var g = (Random().nextInt(255));
    var b = (Random().nextInt(255));
    //get random color
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Color.fromRGBO(r, g, b, 1);

    for (var i = 0; i < segmentations.length; i++) {
      for (var seg in segmentations[i].segments) {
        try {
          //create path object
          Path path = Path();
          //move main point to provided starting point
          path.moveTo(
            transformX(seg[0], size, originalSize!),
            transformY(seg[1], size, originalSize!),
          );
          canvas.drawPath(path, paint);

          //increase 2 because of that first is x, next one is y
          for (int j = 0; j < seg.length - 2; j += 2) {
            path.lineTo(
              transformX(seg[j + 2], size, originalSize!),
              transformY(seg[j + 3], size, originalSize!),
            );
          }

          canvas.drawPath(path, paint);
          // ignore: empty_catches
        } catch (err) {}
      }
    }
  }

  //determine x coordintae based on image size-width
  double transformX(num x, Size newSize, Size oldSize) {
    return x * newSize.width / oldSize.width;
  }

  //determine y coordintae based on image size-height
  double transformY(num y, Size newSize, Size oldSize) {
    return y * newSize.height / oldSize.height;
  }

  @override
  bool shouldRepaint(SegmentationPainter oldDelegate) {
    return oldDelegate.segmentations != segmentations;
  }
}
