import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math.dart';
import 'package:position_sensors/position_sensors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _sensors = [];
  Quaternion _sensorQuartenion = Quaternion(0.0, 0.0, 0.0, 1.0);
  Quaternion _kernelQuartenion = Quaternion(0.0, 0.0, 0.0, 1.0);
  final Vector3 _rotationDegrees = Vector3(0.0, 0.0, 0.0);
  int _delay = -1;
  double _distance = 0.0;
  double _farValue = 0.0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    List<String> sensors;
    try {
      sensors = await PositionSensors.supportedSensors ?? [];
    } on PlatformException {
      sensors = [];
    }

    try {
      await PositionSensors.setDelay(1);
    } catch (_) {}

    int delay;
    try {
      delay = await PositionSensors.delay ?? -1;
    } on PlatformException {
      delay = -1;
    }

    double farValue;
    try {
      farValue = await PositionSensors.proximityFarValue ?? -1.0;
    } on PlatformException {
      farValue = -1.0;
    }

    if (!mounted) return;
    PositionSensors.gameRotationEvents.listen((e) {
      setState(() {
        /* The TYPE_GAME_ROTATION_VECTOR is a virtual sensor that uses data from
        the accelerometer and gyroscope, without the space reference from the
        magnetic field sensor, to create a unit Quartenion.
        This code builds the Quarternion type, rotates it using the spatial
        reference provided when pressing the calibrate button, and converts the
        data to degrees.
        */
        _sensorQuartenion = Quaternion(e.x, e.y, e.z, 0.0);
        var q = _kernelQuartenion * _sensorQuartenion;
        var yaw = atan2(2.0 * (q.y * q.z + q.w * q.x),
            q.w * q.w - q.x * q.x - q.y * q.y + q.z * q.z);
        var pitch = asin(-2.0 * (q.x * q.z - q.w * q.y));
        var roll = atan2(2.0 * (q.x * q.y + q.w * q.z),
            q.w * q.w + q.x * q.x - q.y * q.y - q.z * q.z);
        _rotationDegrees.x = (360 * yaw) / pi;
        _rotationDegrees.y = (360 * pitch) / pi;
        _rotationDegrees.z = (360 * roll) / pi;
      });
    });

    PositionSensors.proximityEvents.listen((e) {
      setState(() {
        _distance = e.distance;
      });
    });

    setState(() {
      _sensors = sensors;
      _delay = delay;
      _farValue = farValue;
    });
  }

  void calibrate() {
    setState(() {
      _kernelQuartenion = _sensorQuartenion.clone();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Sensors: $_sensors'),
              Text('Delay: $_delay'),
              Text('Rotation: (${_rotationDegrees.x.round()}°, '
                  '${_rotationDegrees.y.round()}°, '
                  '${_rotationDegrees.z.round()}°)'),
              Text('Proximity: $_distance cm (max is $_farValue cm)'),
              ElevatedButton(
                  onPressed: calibrate, child: const Text('Calibrate'))
            ],
          ),
        ),
      ),
    );
  }
}
