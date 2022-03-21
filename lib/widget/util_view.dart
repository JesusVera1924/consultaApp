import 'package:another_flushbar/flushbar.dart';
import 'package:app_consulta/class/empresa.dart';
import 'package:flutter/material.dart';

class UtilView {
  static late Empresa empresa;

  static String codEmp = "";
  static String codUser = "";
  static String userSeleccionado = "";

  static messageWarning(String _message, BuildContext context) {
    Flushbar(
      margin: const EdgeInsets.all(8),
      message: _message,
      duration: const Duration(seconds: 3),
      icon: const Icon(
        Icons.warning_amber_outlined,
        size: 28.0,
        color: Color.fromARGB(255, 243, 227, 9),
      ),
      leftBarIndicatorColor: const Color.fromARGB(255, 243, 227, 9),
    ).show(context);
  }

  static Color convertColor(String color) {
    Color colorPrimario = Colors.red;
    if (color != "") {
      final colorF = color.replaceAll("#", "0xFF");
      return colorPrimario = Color(int.parse(colorF.toUpperCase()));
    }
    return colorPrimario;
  }

  static int convertColorInt(String color) {
    int colorPrimario = 0;
    if (color != "") {
      final colorF = color.replaceAll("#", "0xFF");
      return colorPrimario = int.parse(colorF.toUpperCase());
    }
    return colorPrimario;
  }

  static String dateFormatDMY(String cadena) {
    DateTime date = DateTime.parse(cadena);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static String convertDateToString(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
