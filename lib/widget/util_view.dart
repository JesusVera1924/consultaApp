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

  static messageSucced(String _message, BuildContext context) {
    Flushbar(
      margin: const EdgeInsets.all(8),
      message: _message,
      duration: const Duration(seconds: 3),
      icon: const Icon(
        Icons.check_box_outlined,
        size: 28.0,
        color: Color.fromARGB(255, 4, 20, 59),
      ),
      leftBarIndicatorColor: const Color.fromARGB(255, 8, 20, 59),
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
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  static String dateFormatYMD(String cadena) {
    return cadena.substring(6, 10) +
        "-" +
        cadena.substring(3, 5) +
        "-" +
        cadena.substring(0, 2);
  }

  static String convertDateToString(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static String convertDateToStringLash(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  static String getStringFormat(String numero, int log) {
    int fix = numero.length; //tamaño del numero
    String resp = ""; // nuevo String a devolver
    String nuevo = "${int.parse(numero)}";
    if (fix <= log) {
      resp = nuevo.padLeft(log, '0');
    }
    return resp;
  }

  static buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
