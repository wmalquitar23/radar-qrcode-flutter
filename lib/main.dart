import 'package:flutter/material.dart';

import 'core/architecture/freddy_app_architecture.dart';
import 'dependency_instantiator.dart';
import 'radar_app.dart' as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  RadarDataInstantiator dataInstantiator = DataInstantiator();
  await dataInstantiator.init();
  runApp(app.RadarApp());
}
