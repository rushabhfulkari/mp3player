import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mp3player/common/utils/check_sample_equality.dart';
import 'package:mp3player/common/utils/waveform_alignment.dart';

bool debugMaxandElapsedDuration(
  Duration? maxDuration,
  Duration? elapsedDuration,
) {
  return maxDuration != null || elapsedDuration != null
      ? elapsedDuration != null && maxDuration != null
      : true;
}

abstract class AudioWaveform extends StatefulWidget {
  AudioWaveform({
    super.key,
    required this.samples,
    required this.height,
    required this.width,
    this.maxDuration,
    this.elapsedDuration,
    required this.showActiveWaveform,
    this.absolute = false,
    this.invert = false,
  })  : assert(
          debugMaxandElapsedDuration(
            maxDuration,
            elapsedDuration,
          ),
          'Both maxDuration and elapsedDuration must be provided.',
        ),
        // assert(
        //   maxDuration == null ? true : maxDuration.inMilliseconds > 0,
        //   'maxDuration must be greater than 0',
        // ),
        assert(
          elapsedDuration == null ? true : elapsedDuration.inMilliseconds >= 0,
          'maxDuration must be greater than 0',
        ),
        assert(
          elapsedDuration == null || maxDuration == null
              ? true
              : elapsedDuration.inMilliseconds <= maxDuration.inMilliseconds,
          'elapsedDuration must be less than or equal to maxDuration',
        ),
        waveformAlignment = absolute
            ? invert
                ? WaveformAlignment.top
                : WaveformAlignment.bottom
            : WaveformAlignment.center;

  final List<double> samples;
  final double height;
  final double width;
  final Duration? maxDuration;
  final Duration? elapsedDuration;
  final bool absolute;
  final bool invert;
  final bool showActiveWaveform;

  @protected
  final WaveformAlignment waveformAlignment;

  @override
  AudioWaveformState<AudioWaveform> createState();
}

abstract class AudioWaveformState<T extends AudioWaveform> extends State<T> {
  late List<double> _processedSamples;
  List<double> get processedSamples => _processedSamples;
  late double _sampleWidth;
  double get sampleWidth => _sampleWidth;

  @protected
  void updateProcessedSamples(List<double> updatedSamples) {
    _processedSamples = updatedSamples;
  }

  late int _activeIndex;
  late List<double> _activeSamples;
  List<double> get activeSamples => _activeSamples;
  Duration? get maxDuration => widget.maxDuration;
  Duration? get elapsedDuration => widget.elapsedDuration;
  bool get showActiveWaveform => widget.showActiveWaveform;
  bool get invert => widget.absolute ? !widget.invert : widget.invert;
  bool get absolute => widget.absolute;

  WaveformAlignment get waveformAlignment => widget.waveformAlignment;

  @protected
  void processSamples() {
    final rawSamples = widget.samples;

    _processedSamples = rawSamples
        .map((e) => absolute ? e.abs() * widget.height : e * widget.height)
        .toList();

    final maxNum =
        _processedSamples.reduce((a, b) => math.max(a.abs(), b.abs()));

    if (maxNum > 0) {
      final multiplier = math.pow(maxNum, -1).toDouble();
      final finalHeight = absolute ? widget.height : widget.height / 2;
      final finalMultiplier = multiplier * finalHeight;

      _processedSamples = _processedSamples
          .map(
            (e) => invert ? -e * finalMultiplier : e * finalMultiplier,
          )
          .toList();
    }
  }

  void _calculateSampleWidth() {
    _sampleWidth = widget.width / (_processedSamples.length);
  }

  @protected
  void _updateActiveIndex() {
    if (maxDuration != null && elapsedDuration != null) {
      final elapsedTimeRatio =
          elapsedDuration!.inMilliseconds / maxDuration!.inMilliseconds;

      _activeIndex = (widget.samples.length * elapsedTimeRatio).round();
    }
  }

  @protected
  void _updateActiveSamples() {
    _activeSamples = _processedSamples.sublist(0, _activeIndex);
  }

  double get activeRatio => _calculateActiveRatio();

  double _calculateActiveRatio() {
    if (maxDuration != null && elapsedDuration != null) {
      return showActiveWaveform
          ? elapsedDuration!.inMilliseconds / maxDuration!.inMilliseconds
          : 0.0;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
    _processedSamples = widget.samples;
    _activeIndex = 0;
    _activeSamples = [];
    _sampleWidth = 0;
    if (_processedSamples.isNotEmpty) {
      processSamples();
      _calculateSampleWidth();
    }
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!checkforSamplesEquality(widget.samples, oldWidget.samples) &&
        widget.samples.isNotEmpty) {
      processSamples();
      _calculateSampleWidth();
      _updateActiveIndex();
      _updateActiveSamples();
    }
    if (widget.showActiveWaveform) {
      if (widget.elapsedDuration != oldWidget.elapsedDuration) {
        _updateActiveIndex();
        _updateActiveSamples();
      }
    }
    if (widget.height != oldWidget.height || widget.width != oldWidget.width) {
      processSamples();
      _calculateSampleWidth();
      _updateActiveSamples();
    }
    if (widget.absolute != oldWidget.absolute) {
      processSamples();
      _updateActiveSamples();
    }
    if (widget.invert != oldWidget.invert) {
      processSamples();
      _updateActiveSamples();
    }
  }
}
