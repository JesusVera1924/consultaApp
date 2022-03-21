import 'package:app_consulta/class/usremp.dart';
import 'package:flutter/material.dart';

Future<String> dialogAcepCanc(BuildContext context, String title,
    List<UsrEmp> listEmp, IconData iconData, Color color) async {
  String op = "";

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Row(
            children: [
              Icon(
                iconData,
                color: color,
                size: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  title,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final fieldValue in listEmp) ...[
                  InkWell(
                    onTap: (() {
                      op = fieldValue.codEmp;
                      Navigator.pop(context);
                    }),
                    child: Container(
                      width: 230,
                      height: 60,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 80,
                            height: 100,
                            child: fieldValue.codEmp == "01"
                                ? Image.asset(
                                    "lib/image/cojapanwp.png",
                                    fit: BoxFit.contain,
                                  )
                                : Image.asset(
                                    "lib/image/logo.jpg",
                                    fit: BoxFit.contain,
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              fieldValue.nomEmp,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ],
            ),
          ),
        );
      });
  return op;
}
