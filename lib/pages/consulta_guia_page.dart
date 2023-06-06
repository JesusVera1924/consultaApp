import 'package:app_consulta/class/guia.dart';
import 'package:app_consulta/datatable/guia_datasource.dart';
import 'package:app_consulta/dialog/dialog_detalle.dart';
import 'package:app_consulta/provider/guia_provider.dart';
import 'package:app_consulta/services/solicitud_api.dart';
import 'package:app_consulta/style/custom_inputs.dart';
import 'package:app_consulta/utils/date_formatter.dart';
import 'package:app_consulta/widget/util_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ConsultaGuiaPage extends StatelessWidget {
  const ConsultaGuiaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta Guias'),
        backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
      ),
      body: const BodyConsulta(),
    );
  }
}

class BodyConsulta extends StatefulWidget {
  const BodyConsulta({Key? key}) : super(key: key);

  @override
  State<BodyConsulta> createState() => _BodyConsultaState();
}

class _BodyConsultaState extends State<BodyConsulta> {
  final solicitudApi = SolicitudApi();

  @override
  void initState() {
    Provider.of<GuiaProvider>(context, listen: false).getGuias();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const colorW = Colors.white;
    final _api = SolicitudApi();
    final provider = Provider.of<GuiaProvider>(context);

    double tamanoFonts = MediaQuery.of(context).size.width < 400 ? 11 : 14;

    void selectDate(String cadena) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
      if (picked != null) {
        setState(() {
          switch (cadena) {
            case 'init':
              provider.txtFechaInicio.text =
                  UtilView.dateFormatDMY(picked.toString());
              break;
            case 'finish':
              provider.txtFechaFin.text =
                  UtilView.dateFormatDMY(picked.toString());
              break;

            default:
          }
        });
      }
    }

    Widget _buildEndSwipeWidget(
        BuildContext context, DataGridRow row, int rowIndex) {
      return GestureDetector(
        onTap: () async {
          await dialogProperty(
              context, provider.listGuias[rowIndex], "0", provider);
        },
        child: Container(
          color: const Color.fromARGB(255, 51, 177, 209),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.assignment_ind_rounded, color: Colors.white, size: 20),
              SizedBox(width: 16.0),
              Text(
                'Info',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildStartSwipeWidget(
        BuildContext context, DataGridRow row, int rowIndex) {
      return GestureDetector(
        onTap: () async {
          UtilView.buildShowDialog(context);
          await provider.findQueryKamrov(provider.listGuias[rowIndex].codEmp,
              provider.listGuias[rowIndex].numGdr);
          await dialogProperty(
              context, provider.listGuias[rowIndex], "1", provider);
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.assignment, color: Colors.white, size: 20),
              SizedBox(width: 16.0),
              Text(
                'Adicional',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      );
    }

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
                    /* const Spacer(),
                    Text("#$contadorGuias") */
                  ],
                ),
                const Divider(thickness: 1),
                Row(
                  children: [
                    const Icon(Icons.corporate_fare_outlined),
                    Text(
                      provider.nomRef,
                      style: TextStyle(fontSize: tamanoFonts),
                    )
                  ],
                ),
                const Divider(thickness: 1),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.directions),
                    Expanded(
                        child: Text(
                      provider.dirRef,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: tamanoFonts),
                    )),
                    const VerticalDivider(thickness: 1, color: Colors.grey),
                    const Icon(Icons.phone_android_outlined),
                    Expanded(
                        child: Text(
                      provider.telRef,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: tamanoFonts),
                    ))
                  ],
                ),
                const Divider(thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          controller: provider.txtFechaInicio,
                          decoration: CustomInputs.boxInputDecorationDatePicker(
                              labelText: 'Inicio',
                              fc: () => selectDate('init')),
                          inputFormatters: [DateFormatter()],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: provider.txtFechaFin,
                          decoration: CustomInputs.boxInputDecorationDatePicker(
                              labelText: 'Fin', fc: () => selectDate('finish')),
                          inputFormatters: [DateFormatter()],
                        ),
                      ),
                    ),
                    /* Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.5,
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                        icon: const Icon(Icons.search),
                        tooltip: "Busqueda Registros",
                        highlightColor: const Color.fromARGB(255, 84, 230, 222),
                        splashColor: Colors.grey[350],
                        onPressed: () => provider.getGuias(),
                      ),
                    ), */
                  ],
                ),
              ],
            ),
          ),
          elevation: 8,
        ),
        FutureBuilder<List<Guia>>(
          future: _api.findGuias(UtilView.userSeleccionado,
              provider.txtFechaInicio.text, provider.txtFechaFin.text),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                provider.listGuias = snapshot.data!;
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 50 / 100,
                  child: SfDataGridTheme(
                      data: SfDataGridThemeData(
                        headerColor:
                            UtilView.convertColor(UtilView.empresa.cl2Emp),
                        headerHoverColor: Colors.transparent,
                      ),
                      child: SfDataGrid(
                        selectionMode: SelectionMode.single,
                        gridLinesVisibility: GridLinesVisibility.both,
                        headerGridLinesVisibility: GridLinesVisibility.both,
                        columnWidthMode: ColumnWidthMode.fill,
                        allowSwiping: true,
                        swipeMaxOffset: 121.0,
                        startSwipeActionsBuilder: _buildStartSwipeWidget,
                        endSwipeActionsBuilder: _buildEndSwipeWidget,
                        source: GuiaDataSource(
                            provider.listGuias, context, tamanoFonts),
                        columns: <GridColumn>[
                          GridColumn(
                            columnName: 'fecha',
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Text(
                                'F.GUIA',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: colorW, fontSize: tamanoFonts),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'numero',
                            label: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'N°GUIA.',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: colorW, fontSize: tamanoFonts),
                              ),
                            ),
                          ),
                          GridColumn(
                            columnName: 'transporte',
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'TRANSPORTE',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: colorW, fontSize: tamanoFonts),
                                )),
                          ),
                          GridColumn(
                            columnName: 'guia',
                            label: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'GUIA.',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: colorW, fontSize: tamanoFonts),
                                )),
                          ),
                          GridColumn(
                              columnName: 'fechaTransporte',
                              label: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'F.TRANSPORTE',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: colorW, fontSize: tamanoFonts),
                                  ))),
                        ],
                      )),
                );
              } else {
                return const Text('No hay guias disponibles');
              }
            } else if (snapshot.hasError) {
              return Center(child: Text("Error ${snapshot.error}"));
            }
            return const Center(child: CircularProgressIndicator());
          },
        )

        /* Expanded(
          child: provider.listGuias.isEmpty
              ? Column(
                  children: const [
                    SizedBox(height: 200),
                    Text('Esperando data...',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    CircularProgressIndicator()
                  ],
                )
              : SfDataGridTheme(
                  data: SfDataGridThemeData(
                    headerColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
                    headerHoverColor: Colors.transparent,
                  ),
                  child: SfDataGrid(
                    selectionMode: SelectionMode.single,
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    columnWidthMode: ColumnWidthMode.fill,
                    allowSwiping: true,
                    swipeMaxOffset: 121.0,
                    startSwipeActionsBuilder: _buildStartSwipeWidget,
                    endSwipeActionsBuilder: _buildEndSwipeWidget,
                    source: GuiaDataSource(provider.listGuias, context),
                    columns: <GridColumn>[
                      GridColumn(
                        columnName: 'fecha',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text(
                            'F.GUIA',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: colorW),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'numero',
                        label: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'N°GUIA.',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: colorW),
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'transporte',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'TRANSPORTE',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: colorW),
                            )),
                      ),
                      GridColumn(
                        columnName: 'guia',
                        label: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: const Text(
                              'GUIA.',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: colorW),
                            )),
                      ),
                      GridColumn(
                          columnName: 'fechaTransporte',
                          label: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8.0),
                              child: const Text(
                                'F.TRANSPORTE',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: colorW),
                              ))),
                    ],
                  )),
        )
      */
      ],
    );
  }
}
