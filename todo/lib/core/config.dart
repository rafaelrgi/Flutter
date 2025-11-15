import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DataSources {
  memory(Icons.memory_outlined, 'Memory'),
  remoteApi(Icons.cloud_outlined, 'Remote API'),
  localDb(Icons.sd_storage_outlined, 'Local DB'),
  none(Icons.cable_sharp, '');

  const DataSources(this.iconData, this.text);
  final IconData iconData;
  final String text;
}

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
