import 'package:flutter/material.dart';
import 'package:mp3player/common/widgets/waveforms/active_waveform_painter.dart';
import 'package:mp3player/common/widgets/waveforms/inactive_waveform_painter.dart';
import 'package:mp3player/core/waveforms/audio_waveforms.dart';

class Waveform extends AudioWaveform {
  Waveform({
    super.key,
    required super.samples,
    required super.height,
    required super.width,
    super.maxDuration,
    super.elapsedDuration,
    this.activeColor = Colors.red,
    this.inactiveColor = Colors.blue,
    this.activeGradient,
    this.inactiveGradient,
    this.borderWidth = 1.0,
    this.activeBorderColor = Colors.white,
    this.inactiveBorderColor = Colors.white,
    super.showActiveWaveform = true,
    super.absolute = false,
    super.invert = false,
    this.isRoundedRectangle = true,
    this.isCentered = false,
  }) : assert(
          borderWidth >= 0 && borderWidth <= 1.0,
          'BorderWidth must be between 0 and 1',
        );

  final Color activeColor;
  final Color inactiveColor;
  final Gradient? activeGradient;
  final Gradient? inactiveGradient;
  final double borderWidth;
  final Color activeBorderColor;
  final Color inactiveBorderColor;
  final bool isRoundedRectangle;
  final bool isCentered;

  @override
  AudioWaveformState<Waveform> createState() => _WaveformState();
}

class _WaveformState extends AudioWaveformState<Waveform> {
  @override
  Widget build(BuildContext context) {
    if (widget.samples.isEmpty) {
      return const SizedBox.shrink();
    }
    final processedSamples = this.processedSamples;
    final activeSamples = this.activeSamples;
    final showActiveWaveform = this.showActiveWaveform;
    final waveformAlignment = this.waveformAlignment;
    final sampleWidth = this.sampleWidth;

    return Stack(
      children: [
        RepaintBoundary(
          child: CustomPaint(
            size: Size(widget.width, widget.height),
            isComplex: true,
            painter: RectangleInActiveWaveformPainter(
              samples: processedSamples,
              color: widget.inactiveColor,
              gradient: widget.inactiveGradient,
              waveformAlignment: waveformAlignment,
              borderColor: widget.inactiveBorderColor,
              borderWidth: widget.borderWidth,
              sampleWidth: sampleWidth,
              isRoundedRectangle: widget.isRoundedRectangle,
              isCentered: widget.isCentered,
            ),
          ),
        ),
        if (showActiveWaveform)
          CustomPaint(
            size: Size(widget.width, widget.height),
            isComplex: true,
            painter: RectangleActiveWaveformPainter(
              color: widget.activeColor,
              activeSamples: activeSamples,
              gradient: widget.activeGradient,
              waveformAlignment: waveformAlignment,
              borderColor: widget.activeBorderColor,
              borderWidth: widget.borderWidth,
              sampleWidth: sampleWidth,
              isRoundedRectangle: widget.isRoundedRectangle,
              isCentered: widget.isCentered,
            ),
          ),
      ],
    );
  }
}
