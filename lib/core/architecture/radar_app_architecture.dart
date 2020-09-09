import 'package:flutter/cupertino.dart';

abstract class RadarApp extends StatelessWidget {
  final RadarDataInstantiator dataInstantiator;
  RadarApp(this.dataInstantiator);
}

abstract class RadarDataInstantiator {
  Future<void> init();
}

abstract class RadarModel {}

abstract class RadarMapper<T extends RadarModel> {
  Map<String, dynamic> toMap(T object);

  T fromMap(Map<String, dynamic> map);

  List<T> fromListMap(List<dynamic> listMap) {
    List<T> list = [];
    listMap.forEach(
      (object) {
        list.add(
          fromMap(object),
        );
      },
    );
    return list;
  }
}

abstract class NetworkInfo {
  Future<bool> get isConnected;
}
