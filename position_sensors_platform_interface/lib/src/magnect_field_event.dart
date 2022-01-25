class MagneticFieldEvent {
  MagneticFieldEvent(this.x, this.y, this.z) {
    xBias = 0.0;
    yBias = 0.0;
    zBias = 0.0;
  }

  MagneticFieldEvent.uncalibrated(
      this.x, this.y, this.z, this.xBias, this.yBias, this.zBias);

  final double x;
  final double y;
  final double z;

  late final double xBias;
  late final double yBias;
  late final double zBias;

  @override
  String toString() => '[MagneticFieldEvent (x: $x, y: $y, z: $z)]';
}
