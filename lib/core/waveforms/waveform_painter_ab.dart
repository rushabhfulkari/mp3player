import 'package:flutter/material.dart';
import 'package:mp3player/common/utils/check_sample_equality.dart';
import 'package:mp3player/common/utils/waveform_alignment.dart';

abstract class WaveformPainter extends CustomPainter {
  WaveformPainter({
    required this.samples,
    required this.color,
    required this.gradient,
    required this.waveformAlignment,
    required this.sampleWidth,
    required this.style,
  });

  final List<double> samples;
  final Color color;
  final Gradient? gradient;
  final WaveformAlignment waveformAlignment;
  final double sampleWidth;
  final PaintingStyle style;
}

abstract class ActiveWaveformPainter extends WaveformPainter {
  ActiveWaveformPainter({
    required super.color,
    required super.gradient,
    required super.sampleWidth,
    required this.activeSamples,
    required super.waveformAlignment,
    super.style = PaintingStyle.stroke,
    this.borderWidth = 0.0,
    this.borderColor = const Color(0x00000000),
  }) : super(
          samples: [],
        );

  final List<double> activeSamples;
  final double borderWidth;
  final Color borderColor;

  bool getShouldRepaintValue(covariant ActiveWaveformPainter oldDelegate) {
    return !checkforSamplesEquality(activeSamples, oldDelegate.activeSamples) ||
        color != oldDelegate.color ||
        gradient != oldDelegate.gradient ||
        waveformAlignment != oldDelegate.waveformAlignment ||
        sampleWidth != oldDelegate.sampleWidth ||
        style != oldDelegate.style ||
        borderWidth != oldDelegate.borderWidth ||
        borderColor != oldDelegate.borderColor;
  }

  @override
  bool shouldRepaint(covariant ActiveWaveformPainter oldDelegate) {
    return getShouldRepaintValue(oldDelegate);
  }
}

abstract class InActiveWaveformPainter extends WaveformPainter {
  InActiveWaveformPainter({
    required super.color,
    required super.gradient,
    required super.samples,
    required super.waveformAlignment,
    required super.sampleWidth,
    super.style = PaintingStyle.stroke,
    this.borderWidth = 0.0,
    this.borderColor = const Color(0x00000000),
  });

  final double borderWidth;
  final Color borderColor;

  bool getShouldRepaintValue(covariant InActiveWaveformPainter oldDelegate) {
    return !checkforSamplesEquality(samples, oldDelegate.samples) ||
        color != oldDelegate.color ||
        gradient != oldDelegate.gradient ||
        waveformAlignment != oldDelegate.waveformAlignment ||
        sampleWidth != oldDelegate.sampleWidth ||
        style != oldDelegate.style ||
        borderWidth != oldDelegate.borderWidth ||
        borderColor != oldDelegate.borderColor;
  }

  @override
  bool shouldRepaint(covariant InActiveWaveformPainter oldDelegate) {
    return getShouldRepaintValue(oldDelegate);
  }
}

abstract class ActiveInActiveWaveformPainter extends WaveformPainter {
  ActiveInActiveWaveformPainter({
    required this.activeColor,
    required super.samples,
    required super.sampleWidth,
    required this.inactiveColor,
    required this.activeRatio,
    required super.waveformAlignment,
    super.style = PaintingStyle.stroke,
    required this.strokeWidth,
  }) : super(
          color: inactiveColor,
          gradient: null,
        );
  final Color inactiveColor;
  final Color activeColor;
  final double activeRatio;
  final double strokeWidth;

  bool getShouldRepaintValue(
    covariant ActiveInActiveWaveformPainter oldDelegate,
  ) {
    return activeRatio != oldDelegate.activeRatio ||
        activeColor != oldDelegate.activeColor ||
        inactiveColor != oldDelegate.inactiveColor ||
        !checkforSamplesEquality(samples, oldDelegate.samples) ||
        color != oldDelegate.color ||
        gradient != oldDelegate.gradient ||
        waveformAlignment != oldDelegate.waveformAlignment ||
        sampleWidth != oldDelegate.sampleWidth ||
        strokeWidth != oldDelegate.strokeWidth ||
        style != oldDelegate.style;
  }

  @override
  bool shouldRepaint(covariant ActiveInActiveWaveformPainter oldDelegate) {
    return getShouldRepaintValue(oldDelegate);
  }
}
