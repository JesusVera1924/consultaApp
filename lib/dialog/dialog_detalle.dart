import 'package:app_consulta/class/guia.dart';
import 'package:app_consulta/provider/guia_provider.dart';
import 'package:flutter/material.dart';

Future<bool> dialogProperty(BuildContext context, Guia guia, String estado,
    GuiaProvider provider) async {
  bool op = false;
  //var f = NumberFormat('###0.00', 'en_US');
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            'INFORMACIÓN',
            textAlign: TextAlign.center,
          ),
          content: estado == "1"
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(child: Text('OBS:')),
                        Expanded(
                            child: Text(
                          guia.obsTra,
                          textAlign: TextAlign.end,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(child: Text('INF:')),
                        Expanded(
                            child: Text(
                          guia.infFac,
                          textAlign: TextAlign.end,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(child: Text('DESTINO:')),
                        Expanded(
                            child: Text(
                          guia.destino,
                          textAlign: TextAlign.end,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(child: Text('ASIGNACION:')),
                        Expanded(
                            child: Text(
                          provider.numero,
                          textAlign: TextAlign.end,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(child: Text('SUPERVISOR:')),
                        Expanded(
                            child: Text(
                          guia.uckGdr,
                          textAlign: TextAlign.end,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(child: Text('EMPACADOR:')),
                        Expanded(
                            child: Text(
                          guia.uckGdr,
                          textAlign: TextAlign.end,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(child: Text('F.MENBRETE:')),
                        Expanded(
                            child: Text(
                          provider.menbrete.split("&")[0].trim(),
                          textAlign: TextAlign.end,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(child: Text('Nombre:')),
                        Expanded(
                            child: Text(
                          guia.nomRef + guia.nomRxf,
                          textAlign: TextAlign.end,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(child: Text('Dirección:')),
                        Expanded(
                            child: Text(
                          guia.dirRef + guia.dirRxf + guia.dirRyf,
                          textAlign: TextAlign.end,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                    const Divider(thickness: 1),
                  ],
                ),
          actions: [
            TextButton.icon(
              onPressed: () {
                op = true;
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.check_circle_outline, color: Colors.green),
              label: const Text('Aceptar'),
            ),
          ],
        );
      });
  return op;
}
