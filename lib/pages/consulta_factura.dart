import 'package:app_consulta/datatable/karmov_datasource.dart';
import 'package:app_consulta/provider/guia_provider.dart';
import 'package:app_consulta/style/custom_inputs.dart';
import 'package:app_consulta/widget/util_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ConsultaFactura extends StatelessWidget {
  const ConsultaFactura({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta Factura'),
        backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
      ),
      backgroundColor: UtilView.convertColor("#abb8c3"),
      body: const BodyFacturaPage(),
    );
  }
}

class BodyFacturaPage extends StatefulWidget {
  const BodyFacturaPage({Key? key}) : super(key: key);

  @override
  State<BodyFacturaPage> createState() => _BodyFacturaPageState();
}

class _BodyFacturaPageState extends State<BodyFacturaPage> {
  double tamanoFonts = 12;
  String numero = "";
  TextEditingController controllerC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GuiaProvider>(context);

    void callMethod() async {
      if (controllerC.text != "") {
        UtilView.buildShowDialog(context);
        numero = UtilView.getStringFormat(controllerC.text, 9);
        await provider.findQueryFactura(numero);
        controllerC.clear();
        Navigator.pop(context);
      }
      setState(() {});
    }

    return Center(
      child: CustomPaint(
        painter: ShapePainter(),
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Información de registro [$numero]',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 200,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: controllerC,
                        decoration: CustomInputs.boxInputDecorationSimple(
                            hint: 'Ingresa # Factura', label: 'Busqueda'),
                        onEditingComplete: () async => callMethod(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                UtilView.convertColor(UtilView.empresa.cl2Emp),
                            textStyle: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        onPressed: () async => callMethod(),
                        icon: const Icon(Icons.search),
                        label: const Text('Buscar'))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Detalle del registro',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 10),
                _buildplantilla(
                    "GUIA:  ",
                    provider.isSelectKarmov == null
                        ? ''
                        : provider.isSelectKarmov!.numMov),
                _buildplantilla(
                    "DESTINO:  ",
                    provider.isSelectGuia == null
                        ? ''
                        : provider.isSelectGuia!.destino),
                _buildplantilla("ASIGNACION:  ",
                    provider.factura == null ? '' : provider.factura!.usrIbs),
                _buildplantilla("SUPERVISOR:  ", provider.supervisor),
                _buildplantilla(
                    "EMPACADOR:  ",
                    provider.isSelectGuia == null
                        ? ''
                        : provider.isSelectGuia!.uckGdr),
                _buildplantilla(
                    "F.MENBRETE:  ", provider.menbrete.split("&")[0].trim()),
                ExpansionTile(
                  title: const Text("Detalle de factura",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                  children: <Widget>[
                    ListTile(
                      title: SfDataGridTheme(
                        data: SfDataGridThemeData(
                            headerColor:
                                UtilView.convertColor(UtilView.empresa.cl2Emp)),
                        child: SfDataGrid(
                          selectionMode: SelectionMode.single,
                          gridLinesVisibility: GridLinesVisibility.both,
                          headerGridLinesVisibility: GridLinesVisibility.both,
                          columnWidthMode: ColumnWidthMode.fill,
                          source: KarmovDataSource(
                              provider.listKarmov, context, tamanoFonts),
                          columns: <GridColumn>[
                            GridColumn(
                              columnName: 'produto',
                              label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'PRODUCT.',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: tamanoFonts),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'cantidad',
                              label: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'CANT.',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: tamanoFonts),
                                ),
                              ),
                            ),
                            GridColumn(
                              columnName: 'faltante',
                              label: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'FALTANTE',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: tamanoFonts),
                                  )),
                            ),
                            GridColumn(
                              columnName: 'observacion',
                              label: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'OBS',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: tamanoFonts),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildplantilla(String x, String y) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(x, style: const TextStyle(fontWeight: FontWeight.bold)),
              Container(
                constraints: BoxConstraints(
                    maxWidth:
                        MediaQuery.of(context).size.width < 500 ? 220 : 600),
                child: Text(
                  y,
                  textAlign: TextAlign.end,
                  maxLines: 2,
                ),
              )
            ],
          ),
          const Divider(thickness: 1)
        ],
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 40)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 40)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
