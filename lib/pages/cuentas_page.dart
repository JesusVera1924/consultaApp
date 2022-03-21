import 'package:app_consulta/class/cc0020.dart';
import 'package:app_consulta/datatable/ctadatasource.dart';
import 'package:app_consulta/provider/cuenta_provider.dart';
import 'package:app_consulta/services/solicitud_api.dart';
import 'package:app_consulta/style/custom_inputs.dart';
import 'package:app_consulta/widget/util_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CuentasPage extends StatelessWidget {
  const CuentasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
      ),
      body: const BodyCuenta(),
    );
  }
}

class BodyCuenta extends StatefulWidget {
  const BodyCuenta({Key? key}) : super(key: key);

  @override
  State<BodyCuenta> createState() => _BodyCuentaState();
}

SfDataGridTheme _buildDataGridForWeb(List<Cc0020> list, BuildContext context) {
  const colorW = Colors.white;

  return SfDataGridTheme(
    data: SfDataGridThemeData(
      headerColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
      headerHoverColor: Colors.transparent,
    ),
    child: SfDataGrid(
      selectionMode: SelectionMode.single,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      source: CtaDataSource(list, context),
      columns: <GridColumn>[
        GridColumn(
          columnName: 'fecha',
          width: 88,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'FECHA.R',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colorW),
            ),
          ),
        ),
        GridColumn(
          columnName: 'cuenta',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'CTA.',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colorW),
            ),
          ),
        ),
        GridColumn(
          columnName: 'valor',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'VALOR',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: colorW),
              )),
        ),
        GridColumn(
          columnName: 'cobrador',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(
                'COB.',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: colorW),
              )),
        ),
        GridColumn(
            columnName: 'codigo',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'BCO.',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: colorW),
                ))),
        GridColumn(
            columnName: 'banco',
            width: 105,
            label: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'BANCO',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: colorW),
                ))),
        GridColumn(
            columnName: 'fechaE',
            
            width: 86,
            label: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'FECHA.E',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: colorW),
                ))),
      ],
    ),
  );
}

class _BodyCuentaState extends State<BodyCuenta> {
  final editingController = TextEditingController();

  @override
  void initState() {
    Provider.of<CuentaProvider>(context, listen: false).cargarCuenta();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CuentaProvider>(context);
    return Column(
      children: [
        Card(
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person),
                    Text(provider.nomAux),
                    const Spacer(),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: editingController,
                        decoration: CustomInputs.boxInputDecorationicon(
                            hint: 'Busqueda', label: 'Busqueda'),
                        onEditingComplete: () {
                          setState(() {
                            provider.filtroCuenta(editingController.text);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const Divider(thickness: 1),
                Row(
                  children: [
                    const Icon(Icons.corporate_fare_outlined),
                    Text(provider.nomRef)
                  ],
                ),
                const Divider(thickness: 1),
                Row(
                  children: [
                    const Icon(Icons.directions),
                    Text(provider.dirRef),
                    const VerticalDivider(thickness: 1, color: Colors.grey),
                    const Icon(Icons.phone_android_outlined),
                    Text(provider.telRef)
                  ],
                ),
              ],
            ),
          ),
          elevation: 8,
        ),
        provider.listCuenta.isNotEmpty
            ? Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: _buildDataGridForWeb(provider.listCuenta, context)))
            : Center(
                child: Column(
                  children: const [
                    SizedBox(
                      height: 220,
                    ),
                    Text(
                      'Cargando data',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.grey),
                    ),
                    CircularProgressIndicator()
                    /* Image.asset(
                              'lib/image/perdida.png',
                            ) */
                  ],
                ),
              ),
        /* FutureBuilder<List<Cc0020>>(
          future:
              api.consultaSolicitudCuenta(provider.empresa, 'DF', provider.emp),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: _buildDataGridForWeb(snapshot.data!, context)));
              } else {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 220,
                      ),
                      const Text(
                        'Sin Registros',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.grey),
                      ),
                      Image.asset(
                        'lib/image/perdida.png',
                      )
                    ],
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return Column(
                children: const [
                  Text(
                    'Error al consumir la informacion',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  )
                ],
              );
            }

            return const CircularProgressIndicator();
          },
        ), */
/*         provider.listCuenta.isNotEmpty
            ? 
            : Column(
                children: [
                  const Text(
                    'Sin Data',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Image.asset(
                    'lib/image/perdida.png',
                  )
                ],
              ), */
      ],
    );
  }
}

buildShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
}
