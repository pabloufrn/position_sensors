class RotationEvent {
  RotationEvent(this.x, this.y, this.z);

  final double x;
  final double y;
  final double z;

  @override
  String toString() => '[RotationEvent (x: $x, y: $y, z: $z)]';
}
