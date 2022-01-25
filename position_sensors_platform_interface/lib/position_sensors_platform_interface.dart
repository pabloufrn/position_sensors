import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:position_sensors_platform_interface/src/magnect_field_event.dart';
import 'package:position_sensors_platform_interface/src/proximity_event.dart';
import 'package:position_sensors_platform_interface/src/rotation_event.dart';

import 'src/method_channel_position_sensors.dart';

export 'src/rotation_event.dart';
export 'src/magnect_field_event.dart';
export 'src/proximity_event.dart';

abstract class PositionSensorsPlatformInterface extends PlatformInterface {
  static final Object _token = Object();

  PositionSensorsPlatformInterface() : super(token: _token);

  static PositionSensorsPlatformInterface _instance =
      MethodChannelPositionSensors();

  static PositionSensorsPlatformInterface get instance => _instance;

  static set instance(PositionSensorsPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<RotationEvent> get rotationEvents {
    throw UnimplementedError('rotationEvents has not been implemented.');
  }

  Stream<RotationEvent> get gameRotationEvents {
    throw UnimplementedError('gameRotationEvents has not been implemented.');
  }

  Stream<RotationEvent> get magneticRotationEvents {
    throw UnimplementedError(
        'magneticRotationEvents has not been implemented.');
  }

  Stream<MagneticFieldEvent> get magneticFieldEvents {
    throw UnimplementedError('magneticFieldEvents has not been implemented.');
  }

  Stream<MagneticFieldEvent> get uncalibratedMagneticFieldEvents {
    throw UnimplementedError(
        'uncalibratedMagneticField has not been implemented.');
  }

  Stream<ProximityEvent> get proximityEvents {
    throw UnimplementedError('proximityEvents has not been implemented.');
  }

  Future<List<String>?> get supportedSensors async {
    throw UnimplementedError('supportedSensors has not been implemented.');
  }

  Future<int?> get delay async {
    throw UnimplementedError('get delay has not been implemented.');
  }

  Future<double?> get proximityFarValue async {
    throw UnimplementedError('get proximityFarValue has not been implemented.');
  }

  Future<void> setDelay(int delay) async {
    throw UnimplementedError('setDelay has not been implemented.');
  }
}
