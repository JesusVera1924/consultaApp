import 'package:app_consulta/class/guia.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

class GuiaDataSource extends DataGridSource {
  GuiaDataSource(this.list, this.context, this.tamano) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = <DataGridRow>[];

  final List<Guia> list;
  final BuildContext context;
  final double tamano;

  /// Building DataGridRows
  void buildDataGridRows() {
    _dataGridRows = list.map<DataGridRow>((Guia team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<String>(columnName: 'fecha', value: team.fecGdr),
        DataGridCell<String>(columnName: 'numero', value: team.numGdr),
        DataGridCell<String>(columnName: 'transporte', value: team.nomCop),
        DataGridCell<String>(columnName: 'guia', value: team.giaCop),
        DataGridCell<String>(columnName: 'fechaTransporte', value: team.fecCop),
      ]);
    }).toList();
  }

  // Overrides
  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        child: Tooltip(
          message: row.getCells()[0].value.toString(),
          child: Text(
            row.getCells()[0].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: tamano),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Tooltip(
          message: row.getCells()[1].value.toString(),
          child: Text(
            row.getCells()[1].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: tamano),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Tooltip(
          message: row.getCells()[2].value.toString(),
          child: Text(
            row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontSize: tamano),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        alignment: Alignment.center,
        child: Tooltip(
          message: row.getCells()[3].value.toString(),
          child: Text(
            row.getCells()[3].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: tamano),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        child: Tooltip(
          message: row.getCells()[4].value.toString(),
          child: Text(
            row.getCells()[4].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: tamano),
          ),
        ),
      ),
    ]);
  }
}
