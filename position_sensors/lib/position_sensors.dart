import 'dart:async';

import 'package:position_sensors/src/sensors.dart';
import 'package:position_sensors_platform_interface/position_sensors_platform_interface.dart';

final Sensors _sensors = Sensors();

class PositionSensors {
  static Future<List<String>?> get supportedSensors async {
    return _sensors.supportedSensors;
  }

  static Future<int?> get delay async {
    return _sensors.delay;
  }

  static Future<double?> get proximityFarValue async {
    return _sensors.proximityFarValue;
  }

  static Future<void> setDelay(int delay) async {
    return _sensors.setDelay(delay);
  }

  static Stream<RotationEvent> get rotationEvents {
    return _sensors.rotationEvents;
  }

  static Stream<RotationEvent> get gameRotationEvents {
    return _sensors.gameRotationEvents;
  }

  static Stream<RotationEvent> get magneticRotationEvents {
    return _sensors.magneticRotationEvents;
  }

  static Stream<MagneticFieldEvent> get magneticFieldEvents {
    return _sensors.magneticFieldEvents;
  }

  static Stream<MagneticFieldEvent> get uncalibratedMagneticFieldEvents {
    return _sensors.uncalibratedMagneticFieldEvents;
  }

  static Stream<ProximityEvent> get proximityEvents {
    return _sensors.proximityEvents;
  }
}
