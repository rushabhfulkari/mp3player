enum WaveformAlignment {
  top,
  center,
  bottom,
}

extension WaveformAlignmentExtension on WaveformAlignment {
  double getAlignPosition(double height) {
    switch (this) {
      case WaveformAlignment.top:
        return 0;
      case WaveformAlignment.center:
        return height / 2;
      case WaveformAlignment.bottom:
        return height;
    }
  }
}
