import 'package:shared_preferences/shared_preferences.dart';

enum DataSources { memory, remoteApi, localDb, none }

//Singleton? Config config = Config();

class Config {
  //
  static const _datasourceKey = 'DataSource';

  static Future<DataSources> getDataSource() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      int i = prefs.getInt(_datasourceKey) ?? 0;
      return DataSources.values[i];
    } catch (e) {
      return DataSources.memory;
    }
  }

  static Future<void> setDataSource(DataSources ds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_datasourceKey, ds.index);
  }
}

extension DataSourcesExtensions on DataSources {
  String asString() {
    switch (this) {
      case DataSources.memory:
        return 'Memory';
      case DataSources.remoteApi:
        return 'Remote API';
      case DataSources.localDb:
        return 'Local DB';
      case DataSources.none:
        return '';
    }
  }
}
