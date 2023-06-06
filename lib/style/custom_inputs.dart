import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    );
  }

  static InputDecoration boxInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      labelText: label,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration boxInputDecorationGrey({
    required String hint,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[300],
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      labelText: label,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      prefixIcon: Icon(icon, color: Colors.black),
      labelStyle: const TextStyle(color: Colors.black54),
    );
  }

  static InputDecoration boxInputDecorationSimple({
    required String hint,
    required String label,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      labelText: label,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration boxInputDecorationFunctionClear(
      {required String hintText, required Function fc}) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3))),
        hintText: hintText,
        isDense: true,
        filled: true,
        fillColor: const Color.fromARGB(255, 233, 229, 229),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        suffixIcon: InkWell(
          onTap: () => fc(),
          child: const Icon(Icons.clear),
        ));
  }

  static InputDecoration boxInputDecorationIconAdd(
      {required String labelText,
      String? mensaje = 'Mensaje',
      required Function fc}) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        labelText: labelText,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        suffixIcon: InkWell(
          onTap: () => fc(),
          child: Tooltip(
              message: mensaje,
              child: const Icon(
                Icons.add_outlined,
              )),
        ));
  }

  static InputDecoration boxInputDecorationDatePicker(
      {required String labelText, required Function fc}) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
        labelText: labelText,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        suffixIcon: InkWell(
          onTap: () => fc(),
          child: const Icon(Icons.calendar_today),
        ));
  }

  static InputDecoration boxInputDecoration2({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration boxInputDecorationDialogSearch({
    required String hint,
    required String label,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))),
      hintText: hint,
      labelText: label,
      isDense: true,
      contentPadding: const EdgeInsets.all(12.0),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }
}
