import 'package:flutter/material.dart';
import 'package:mp3player/core/waveforms/waveform_painter_ab.dart';
import 'package:mp3player/common/utils/waveform_alignment.dart';

class RectangleActiveWaveformPainter extends ActiveWaveformPainter {
  RectangleActiveWaveformPainter({
    required super.color,
    required super.activeSamples,
    required super.waveformAlignment,
    required super.sampleWidth,
    required super.borderColor,
    required super.borderWidth,
    required this.isRoundedRectangle,
    required this.isCentered,
    super.gradient,
    super.style = PaintingStyle.fill,
  });
  final bool isRoundedRectangle;
  final bool isCentered;

  @override
  void paint(Canvas canvas, Size size) {
    final activeTrackPaint = Paint()
      ..style = style
      ..color = color
      ..shader = gradient?.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = borderColor
      ..strokeWidth = borderWidth;

    final alignPosition = waveformAlignment.getAlignPosition(size.height);

    if (isRoundedRectangle) {
      drawRoundedRectangles(
        canvas,
        alignPosition,
        activeTrackPaint,
        borderPaint,
        waveformAlignment,
        isCentered,
      );
    } else {
      drawRegularRectangles(
        canvas,
        alignPosition,
        activeTrackPaint,
        borderPaint,
        waveformAlignment,
        isCentered,
      );
    }
  }

  void drawRegularRectangles(
    Canvas canvas,
    double alignPosition,
    Paint paint,
    Paint borderPaint,
    WaveformAlignment waveformAlignment,
    bool isCentered,
  ) {
    for (var i = 0; i < activeSamples.length; i++) {
      final x = sampleWidth * i;
      final isAbsolute = waveformAlignment != WaveformAlignment.center;
      final y =
          isCentered && !isAbsolute ? activeSamples[i] * 2 : activeSamples[i];
      final positionFromTop =
          isCentered && !isAbsolute ? alignPosition - y / 2 : alignPosition;
      canvas
        ..drawRect(
          Rect.fromLTWH(x, positionFromTop, sampleWidth, y),
          paint,
        )
        ..drawRect(
          Rect.fromLTWH(x, positionFromTop, sampleWidth, y),
          borderPaint,
        );
    }
  }

  void drawRoundedRectangles(
    Canvas canvas,
    double alignPosition,
    Paint paint,
    Paint borderPaint,
    WaveformAlignment waveformAlignment,
    bool isCentered,
  ) {
    for (var i = 0; i < activeSamples.length; i++) {
      if (i.isEven) {
        final x = sampleWidth * i;
        final isAbsolute = waveformAlignment != WaveformAlignment.center;
        final y = isAbsolute
            ? activeSamples[i]
            : !isCentered
                ? activeSamples[i]
                : activeSamples[i] * 2;
        final positionFromTop = isAbsolute
            ? alignPosition
            : !isCentered
                ? alignPosition
                : alignPosition - y / 2;

        canvas
          ..drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(x, positionFromTop, sampleWidth, y),
              Radius.circular(x),
            ),
            paint,
          )
          ..drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(x, positionFromTop, sampleWidth, y),
              Radius.circular(x),
            ),
            borderPaint,
          );
      }
    }
  }

  @override
  bool shouldRepaint(covariant RectangleActiveWaveformPainter oldDelegate) {
    return getShouldRepaintValue(oldDelegate) ||
        isRoundedRectangle != oldDelegate.isRoundedRectangle ||
        isCentered != oldDelegate.isCentered;
  }
}
