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
    final provider = Provider.of<GuiaProvider>(context);

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
        onTap: () {
          dialogProperty(context, provider.listGuias[rowIndex], "0");
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

    /// Callback for left swiping, and it will flipped for RTL case
    Widget _buildStartSwipeWidget(
        BuildContext context, DataGridRow row, int rowIndex) {
      return GestureDetector(
        onTap: () {
          dialogProperty(context, provider.listGuias[rowIndex], "1");
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
                    const Spacer(),
                    Text("#${provider.listGuias.length}")
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
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.directions),
                    Expanded(
                        child: Text(
                      provider.dirRef,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )),
                    const VerticalDivider(thickness: 1, color: Colors.grey),
                    const Icon(Icons.phone_android_outlined),
                    Expanded(
                        child: Text(
                      provider.telRef,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ))
                  ],
                ),
                const Divider(thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /* Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: provider.txtUsuario,
                      decoration: CustomInputs.boxInputDecorationGrey(
                          hint: 'USUARIO',
                          label: 'USUARIO',
                          icon: Icons.person),
                    ),
                  ),
                ), */
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
                    Container(
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
                    ),
                  ],
                ),
              ],
            ),
          ),
          elevation: 8,
        ),
        /*    Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Card(
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: provider.txtUsuario,
                      decoration: CustomInputs.boxInputDecorationGrey(
                          hint: 'USUARIO',
                          label: 'USUARIO',
                          icon: Icons.person),
                    ),
                  ),
                ), */
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFormField(
                      controller: provider.txtFechaInicio,
                      decoration: CustomInputs.boxInputDecorationDatePicker(
                          labelText: 'Inicio', fc: () => selectDate('init')),
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
                Container(
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
                ),
              ],
            ),
          ),
        ),
 */
        /*    provider.cliente == null
            ? const Text('')
            : Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Card(
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              "Nombre: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              provider.cliente!.nomRef,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              "Telefono: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              provider.cliente!.telRef,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              "Direccion: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              provider.cliente!.dirRef,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              "Vendedor: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              provider.cliente!.nomAux,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      */

        Expanded(
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
      ],
    );
  }
}
