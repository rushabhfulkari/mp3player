import 'package:flutter/material.dart';
import 'package:mp3player/core/waveforms/waveform_painter_ab.dart';
import 'package:mp3player/common/utils/waveform_alignment.dart';

class RectangleInActiveWaveformPainter extends InActiveWaveformPainter {
  RectangleInActiveWaveformPainter({
    super.color = Colors.white,
    super.gradient,
    required super.samples,
    required super.waveformAlignment,
    required super.sampleWidth,
    required super.borderColor,
    required super.borderWidth,
    required this.isRoundedRectangle,
    required this.isCentered,
    super.style = PaintingStyle.fill,
  });

  final bool isRoundedRectangle;
  final bool isCentered;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
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
    final isAbsolute = waveformAlignment != WaveformAlignment.center;

    if (isRoundedRectangle) {
      drawRoundedRectangles(
        canvas,
        alignPosition,
        paint,
        borderPaint,
        waveformAlignment,
        isCentered,
        isAbsolute,
      );
    } else {
      drawRegularRectangles(
        canvas,
        alignPosition,
        paint,
        borderPaint,
        waveformAlignment,
        isCentered,
        isAbsolute,
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
    bool isAbsolute,
  ) {
    final isCenteredAndNotAbsolute = isCentered && !isAbsolute;
    for (var i = 0; i < samples.length; i++) {
      final x = sampleWidth * i;
      final y = isCenteredAndNotAbsolute ? samples[i] * 2 : samples[i];
      final positionFromTop =
          isCenteredAndNotAbsolute ? alignPosition - y / 2 : alignPosition;
      final rectangle = Rect.fromLTWH(x, positionFromTop, sampleWidth, y);

      canvas
        ..drawRect(
          rectangle,
          paint,
        )
        ..drawRect(
          rectangle,
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
    bool isAbsolute,
  ) {
    final radius = Radius.circular(sampleWidth);
    final isAbsoluteAndNotCentered = isAbsolute || !isCentered;
    for (var i = 0; i < samples.length; i++) {
      if (i.isEven) {
        final x = sampleWidth * i;
        final y = isAbsoluteAndNotCentered ? samples[i] : samples[i] * 2;
        final positionFromTop =
            isAbsoluteAndNotCentered ? alignPosition : alignPosition - y / 2;
        final rectangle = Rect.fromLTWH(x, positionFromTop, sampleWidth, y);
        canvas
          ..drawRRect(
            RRect.fromRectAndRadius(
              rectangle,
              radius,
            ),
            paint,
          )
          ..drawRRect(
            RRect.fromRectAndRadius(
              rectangle,
              radius,
            ),
            borderPaint,
          );
      }
    }
  }

  @override
  bool shouldRepaint(covariant RectangleInActiveWaveformPainter oldDelegate) {
    return getShouldRepaintValue(oldDelegate) ||
        isRoundedRectangle != oldDelegate.isRoundedRectangle ||
        isCentered != oldDelegate.isCentered;
  }
}
