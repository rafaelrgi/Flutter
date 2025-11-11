import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DataSources { memory, remoteApi, localDb, none }

class Config {
  //
  static const _themeKey = 'Theme';
  static const _datasourceKey = 'DataSource';

  static Future<ThemeMode> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    int i = prefs.getInt(_themeKey) ?? 0;
    return ThemeMode.values[i];
  }

  static Future<void> setTheme(ThemeMode val) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, val.index);
  }

  static Future<DataSources> getDataSource() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      int i = prefs.getInt(_datasourceKey) ?? 0;
      return DataSources.values[i];
    } catch (e) {
      return DataSources.memory;
    }
  }

  static Future<void> setDataSource(DataSources val) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_datasourceKey, val.index);
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
