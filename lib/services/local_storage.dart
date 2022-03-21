import 'dart:convert';

import 'package:app_consulta/class/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future createCache(User usuario) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('usuario', json.encode(usuario.toMap()));
    // print("1");
  }

  Future readCache(String usuario) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString(usuario);
    // print("2");
    return cache;
  }

  Future removeCache(String usuario) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove(usuario);
  }

  Future createCacheSingle(String value, String referencia) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString(referencia, value);
    // print("1.5");
  }

  Future createCacheSinglebool(bool value, String referencia) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setBool(referencia, value);
    // print("1.6");
  }
}



/* 
 static Future<String> saveSettings(Usuario usuario) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('usuario', json.encode(usuario.toMap()));
    return 'usuario guardado';
  }

 */