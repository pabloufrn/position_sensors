class ProximityEvent {
  ProximityEvent(this.distance);

  final double distance;

  @override
  String toString() => '[ProximityEvent (distance: $distance)]';
}
